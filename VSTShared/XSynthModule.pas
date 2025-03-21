unit XSynthModule;

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//  Version: MPL 1.1 or LGPL 2.1 with linking exception                       //
//                                                                            //
//  The contents of this file are subject to the Mozilla Public License       //
//  Version 1.1 (the "License"); you may not use this file except in          //
//  compliance with the License. You may obtain a copy of the License at      //
//  http://www.mozilla.org/MPL/                                               //
//                                                                            //
//  Software distributed under the License is distributed on an "AS IS"       //
//  basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the   //
//  License for the specific language governing rights and limitations under  //
//  the License.                                                              //
//                                                                            //
//  Alternatively, the contents of this file may be used under the terms of   //
//  the Free Pascal modified version of the GNU Lesser General Public         //
//  License Version 2.1 (the "FPC modified LGPL License"), in which case the  //
//  provisions of this license are applicable instead of those above.         //
//  Please see the file LICENSE.txt for additional information concerning     //
//  this license.                                                             //
//                                                                            //
//  The code is part of the Delphi ASIO & VST Project                         //
//                                                                            //
//  The initial developer of this code is Christian-W. Budde                  //
//                                                                            //
//  Portions created by Christian-W. Budde are Copyright (C) 2008-2012        //
//  by Christian-W. Budde. All Rights Reserved.                               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

interface

{$I DAV_Compiler.inc}

uses
  Windows, Messages, SysUtils, Classes, Forms, DAV_Types, DAV_VSTEffect,UIXPlugin,DAV_VSTModule;

type
  TVSTSSModule = class(TVSTModule)
    procedure VSTModuleOpen(Sender: TObject);
    procedure VSTModuleClose(Sender: TObject);
    procedure VSTModuleProcessMidi(Sender: TObject; MidiEvent: TVstMidiEvent);
    procedure VSTModuleProcess32Replacing(const Inputs, Outputs: TDAVArrayOfSingleFixedArray; const SampleFrames: Cardinal);
    procedure VSTModuleEditOpen(Sender: TObject; var GUI: TForm;
      ParentWindow: NativeUInt);
    procedure CustomParameterDisplay(Sender: TObject; const Index: Integer; var PreDefined: AnsiString);
    procedure VSTModuleEditClose(Sender: TObject; var DestroyForm: Boolean);
    procedure VSTModuleSampleRateChange(Sender: TObject;
      const SampleRate: Single);
    procedure VSTSSModulePrograms0LoadChunk(Sender: TObject;    const Index: Integer; const isPreset: Boolean);
    procedure VSTSSModulePrograms0StoreChunk(Sender: TObject;   const Index: Integer; const isPreset: Boolean);
    procedure VSTModuleCreate(Sender: TObject);
    procedure VSTModuleDestroy(Sender: TObject);
  private
    FCurTempo:double;
    FModel  : IXPlugin;
    function HostCallGetProductString (const Index: Integer; const Value: TVstIntPtr; const ptr: Pointer; const opt: Single): TVstIntPtr; override;
    function GetUniqueID: AnsiString; override;
    procedure OnParameterChanged(Sender: TObject; const Index: Integer;  var Value: Single);
    procedure CheckTempo;
    procedure LoadChunk(const AProgramIndex: Integer);virtual;
    procedure StoreChunk(const AProgramIndex: Integer);virtual;
    function To0_127(index:integer;value:single):integer;
    function From0_127(index:integer;value:integer):single;

  public
    procedure AddParameter(id:integer;displayname:string;min,max:integer;def:single;units:string;customparameters:string='');
    procedure ModelSetParameter(const Index, Value: Integer);
    procedure ResendParameters;
  end;

implementation

{$IFDEF FPC}
{$R *.LFM}
{$ELSE}
{$R *.DFM}
{$ENDIF}

uses
  Math, DAV_Common, DAV_Approximations, DAV_VSTParameters, XPluginFactory, Dialogs,DAV_VSTPrograms,UDataLayer,UMidiEvent,
  CodeSiteLogging;

const PROGRAMCOUNT = 32;
type TMyVstParameterProperty = class(TVstParameterProperty)
public
  FCustomParameters:string;
  FDef:single;
  function To0_127(value:single):integer;
  function From0_127(value:integer):single;
end;

procedure TVSTSSModule.AddParameter(id:integer;displayname:string;min,max:integer;def:single;units:string;customparameters:string);
VAR param:TMyVstParameterProperty;
begin
  param:=TMyVstParameterProperty(ParameterProperties[id]);
  param.DisplayName:=displayname;
  param.Min:=min;
  param.max:=max;
  param.Fdef:=def;
  param.Units:=units;
  param.OnParameterChange:=OnParameterChanged;
  param.FCustomParameters:=CustomParameters;
  if CustomParameters<>'' then
    param.OnCustomParameterDisplay:=CustomParameterDisplay;
end;

procedure TVSTSSModule.OnParameterChanged(Sender: TObject; const Index: Integer; var Value: Single);
begin
  if (index>=0) and (index<numParams) then
      FModel.OnParameterChanged(self,index,To0_127(index,value));
end;

procedure TVSTSSModule.ResendParameters;
VAR i:integer;
    v:single;
begin
  for i:=0 to numParams-1 do
  begin
    v:=Parameter[i];
    OnParameterChanged(self,i,v);
  end;
end;

function TVSTSSModule.From0_127(index, value: integer): single;
begin
  if (index>=0) and (index<numParams) then
  with TMyVstParameterProperty(ParameterProperties[Index]) do
    result:=From0_127(value);
end;

function TVSTSSModule.To0_127(index: integer; value: single): integer;
begin
  if (index>=0) and (index<numParams) then
  with TMyVstParameterProperty(ParameterProperties[Index]) do
    result:=To0_127(value);
end;

procedure TVSTSSModule.ModelSetParameter(const Index,Value: Integer);
begin
  if (index>=0) and (index<numParams) then
    Parameter[Index]:=From0_127(index,value);
end;

function TwoStr(n: integer): string;
begin
  result := inttostr(n);
  if n < 10 then
    result := '0' + result;
end;


procedure TVSTSSModule.VSTModuleOpen(Sender: TObject);
VAR i,prg:integer;
VAR param:TMyVstParameterProperty;
    v:single;
    progr:TVstProgram;
begin
  About:='VST Plugin by Christian Budde, Tobybear & Ruud Ermers';
//  //CodeSite.Send('VSTModuleOpen');

  FModel:= XPluginFactory.CreateObject(self,SampleRate);
  for i:=0 to FModel.ParamCount-1 do
  begin
    param:=TMyVstParameterProperty.Create(ParameterProperties);
    param.VSTModule:=self;
  end;
  FModel.AddParameters;

  for prg:=1 to PROGRAMCOUNT-1 do
  begin
    progr:=TVstProgram.Create(Programs);
    progr.VSTModule:=self;
    progr.DisplayName:='Preset '+TwoStr(prg+1);
    progr.OnLoadChunk:=VSTSSModulePrograms0LoadChunk;
    progr.OnStoreChunk:=VSTSSModulePrograms0StoreChunk;
  end;
  for prg:=0 to PROGRAMCOUNT-1 do
  with Programs[prg] do
   for i:=0 to numParams-1 do
     Parameter[i] := TMyVstParameterProperty(ParameterProperties[i]).FDef;
  for i:=0 to numParams-1 do
  begin
    v:=Parameter[ i];
    OnParameterChanged(self,i,v);
  end;
 // set editor form class
  EditorFormClass := FModel.GetFormClass;
end;

procedure TVSTSSModule.VSTModuleClose(Sender: TObject);
begin
  //CodeSite.Send('VSTModuleClose');
  FModel.Close;
  //CodeSite.Send('VSTModuleClosed');
end;

procedure TVSTSSModule.VSTModuleCreate(Sender: TObject);
begin
  //CodeSite.Send('VSTModuleCreate');
end;

procedure TVSTSSModule.VSTModuleDestroy(Sender: TObject);
begin
   //CodeSite.Send('VSTModuleDestroy');
end;

procedure TVSTSSModule.VSTModuleEditClose(Sender: TObject;  var DestroyForm: Boolean);
begin
  // //CodeSite.Send('VSTModuleEditClose');
  FModel.SetEditor(NIL);
end;

procedure TVSTSSModule.VSTModuleEditOpen(Sender: TObject; var GUI: TForm;
  ParentWindow: NativeUInt);
begin
  //CodeSite.Send('VSTModuleEditOpen');
  FModel.SetEditor(GUI);
end;


procedure TVSTSSModule.CheckTempo;
var
  TimeInfo : PVstTimeInfo;
  Tempo:double;
begin
  TimeInfo := GetTimeInfo(32767);
  if VtiTempoValid in TimeInfo^.flags then
    begin
      Tempo := TimeInfo^.Tempo;
      if FCurTempo<>Tempo then
      begin
        FCurTempo:=Tempo;
        FModel.SetTempo(Tempo);
      end;
    end;
end;

procedure TVSTSSModule.VSTModuleProcess32Replacing(const Inputs,  Outputs: TDAVArrayOfSingleFixedArray; const SampleFrames: Cardinal);
begin
  CheckTempo;
  FModel.Process(Inputs,Outputs,SampleFrames);
end;

procedure TVSTSSModule.VSTModuleProcessMidi(Sender: TObject;  MidiEvent: TVstMidiEvent);
VAR m:TMidiEvent;
begin
  m.status:=MidiEvent.MidiData[0] and $F0;
  m.midichannel:=MidiEvent.MidiData[0] and $F;
  m.data1:=MidiEvent.MidiData[1];
  m.data2:=MidiEvent.MidiData[2];
  FModel.ProcessMidi(Sender,M);
  MidiOut(MidiEvent.MidiData[0],MidiEvent.MidiData[1],MidiEvent.MidiData[2],MidiEvent.MidiData[3]);
end;

procedure TVSTSSModule.VSTModuleSampleRateChange(Sender: TObject;
  const SampleRate: Single);
begin
  if FModel<>NIL then FModel.SetSampleRate(SampleRate);
end;


const CHUNK_MAGIC = 4713564;
procedure TVSTSSModule.LoadChunk(const AProgramIndex: Integer);
VAR i,n:integer;
    sl:TDataLayerSection;
    s:string;
begin
//  CodeSite.Send('Load Chunk');

  with Programs[AProgramIndex] do
   begin
     Chunk.Position := 0;
     Chunk.Read(n,sizeof(integer));
     if n<>CHUNK_MAGIC then exit;
     sl:=TDataLayerSection.Create;
     sl.LoadFromStream(Chunk);
     s:=sl.GetAttribute('Programname');
     if s<>'' then DisplayName:=s;
     for i:=0 to ParameterCount-1 do
     begin
       n:=StrToIntDef(sl.GetAttribute(ParameterProperties[i].DisplayName),-1);
       if (n>=0) and (n<=127) then
         Parameter[i]:=From0_127(i,n);
       if AProgramIndex = CurrentProgram then
         self.Parameter[i]:=Parameter[i];
     end;
     sl.Free;
  end;
end;

procedure TVSTSSModule.StoreChunk(  const AProgramIndex: Integer);
VAR i,n:integer;
VAR sl:TDataLayerSection;
begin
//  CodeSite.Send('Store Chunk');
  with Programs[AProgramIndex] do
   begin
    Chunk.Position := 0;
    n:=CHUNK_MAGIC;
    Chunk.Write(n,sizeof(integer));
    sl:=TDataLayerSection.Create;
    sl.SetAttribute('Programname',DisplayName);
    for i:=0 to ParameterCount-1 do
      sl.SetAttribute(ParameterProperties[i].DisplayName,IntToStr(To0_127(i,Parameter[i])));
    sl.SaveToStream(chunk);
    sl.Free;
  end;
end;

procedure TVSTSSModule.VSTSSModulePrograms0LoadChunk(Sender: TObject;  const Index: Integer; const isPreset: Boolean);
begin
  LoadChunk(Index);
end;

procedure TVSTSSModule.VSTSSModulePrograms0StoreChunk(Sender: TObject;  const Index: Integer; const isPreset: Boolean);
begin
  StoreChunk(Index);
end;

procedure TVSTSSModule.CustomParameterDisplay(Sender: TObject; const Index: Integer; var PreDefined: AnsiString);
const recip127 = 1/127;
    function LFO:string;
    VAR sv:single;
    begin
      sv:=0.1*exp(0.0598*Parameter[index]);
      result:=floattostr(sv);
      result:=Copy(result,1,4);
    end;
    function Cutoff:string;
    VAR sv:single;
    begin
      result:=inttostr(round(Parameter[index]));
    end;
    function Selection(s:string):string;
    VAR i,p,n:integer;
    begin
      n:=round(Parameter[index]);
      for i:=1 to length(s) do
      begin
        if n=0 then
        begin
          s:=Copy(s,i);
          p:=pos(';',s);
          if p=0 then result:=s
                 else result:=Copy(s,1,p-1);
          exit;
        end;
        if s[i]=';' then dec(n);
      end;
    end;
VAR s:string;
begin
  s:=TMyVstParameterProperty(ParameterProperties[Index]).FCustomParameters;
  if s<>'' then
  begin
    if s='__LFO' then PreDefined:= LFO
    else if s = '__CUTOFF' then PreDefined:=CutOff
    else PreDefined:=Selection(s);
  end;
end;

function TVSTSSModule.GetUniqueID: AnsiString;
begin
  SetUniqueID(XPluginFactory.UniqueID);
  result:=inherited;
end;

function TVSTSSModule.HostCallGetProductString(const Index: Integer;
  const Value: TVstIntPtr; const ptr: Pointer; const opt: Single): TVstIntPtr;
begin
  SetProductName(XPluginFactory.ProductName);
  result:=inherited;
end;

{ TMyVstParameterProperty }

function TMyVstParameterProperty.From0_127(value: integer): single;
begin
  result:=min+Value * (max-min) / 127;
end;

function TMyVstParameterProperty.To0_127(value:single): integer;
begin
  if max>min then
    result:=round((value-min) / (max-min) * 127);
end;

end.

