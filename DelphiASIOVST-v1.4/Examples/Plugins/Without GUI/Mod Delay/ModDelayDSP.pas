unit ModDelayDSP;

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
//  Portions created by Christian-W. Budde are Copyright (C) 2009-2012        //
//  by Christian-W. Budde. All Rights Reserved.                               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

interface

{$I DAV_Compiler.inc}

uses 
  {$IFDEF FPC}LCLIntf, LResources, {$ELSE} Windows, {$ENDIF} SysUtils, Classes,
  Forms, SyncObjs, DAV_Types, DAV_VSTModule, DAV_DspModDelay;

type
  TModDelayModule = class(TVSTModule)
    procedure VSTModuleCreate(Sender: TObject);
    procedure VSTModuleDestroy(Sender: TObject);
    procedure VSTModuleOpen(Sender: TObject);
    procedure VSTModuleClose(Sender: TObject);
    procedure VSTModuleSampleRateChange(Sender: TObject; const SampleRate: Single);
    procedure VSTModuleProcess(const Inputs, Outputs: TDAVArrayOfSingleFixedArray; const SampleFrames: Cardinal);
    procedure ParameterLowpassDisplay(Sender: TObject; const Index: Integer; var PreDefined: AnsiString);
    procedure ParameterLowpassLabel(Sender: TObject; const Index: Integer; var PreDefined: AnsiString);
    procedure ParameterLowpassChange(Sender: TObject; const Index: Integer; var Value: Single);
    procedure ParameterGainChange(Sender: TObject; const Index: Integer; var Value: Single);
    procedure ParameterGainDisplay(Sender: TObject; const Index: Integer; var PreDefined: AnsiString);
    procedure ParameterMixChange(Sender: TObject; const Index: Integer; var Value: Single);
    procedure ParameterDelayChange(Sender: TObject; const Index: Integer; var Value: Single);
    procedure ParameterDepthChange(Sender: TObject; const Index: Integer; var Value: Single);
    procedure ParameterRateChange(Sender: TObject; const Index: Integer; var Value: Single);
    procedure ParameterFeedbackChange(Sender: TObject; const Index: Integer; var Value: Single);
  private
    FCriticalSection : TCriticalSection;
    FGain            : Single;
    FModDelay        : TModDelay32;
  public
  end;

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

uses
  Math, DAV_Common, DAV_VSTCustomModule;

procedure TModDelayModule.VSTModuleCreate(Sender: TObject);
begin
 FCriticalSection := TCriticalSection.Create;
end;

procedure TModDelayModule.VSTModuleDestroy(Sender: TObject);
begin
 FreeAndNil(FCriticalSection);
end;

procedure TModDelayModule.VSTModuleOpen(Sender: TObject);
begin
 FModDelay := TModDelay32.Create;
 FModDelay.SampleRate := SampleRate;

 // initialize default parameters
 Parameter[0] := -3;
 Parameter[1] := 25;
 Parameter[2] := 22000;
 Parameter[3] := 20;
 Parameter[4] := 20;
 Parameter[5] := 2;
 Parameter[6] := 10;
end;

procedure TModDelayModule.VSTModuleClose(Sender: TObject);
begin
 FreeAndNil(FModDelay);
end;

procedure TModDelayModule.ParameterGainDisplay(
  Sender: TObject; const Index: Integer; var PreDefined: AnsiString);
begin
 Predefined := FloatToAnsiString(RoundTo(Parameter[Index], -2), 3);
end;

procedure TModDelayModule.ParameterMixChange(
  Sender: TObject; const Index: Integer; var Value: Single);
begin
 FCriticalSection.Enter;
 try
  if Assigned(FModDelay)
   then FModDelay.Mix := Value;
 finally
  FCriticalSection.Leave;
 end;
end;

procedure TModDelayModule.ParameterDepthChange(
  Sender: TObject; const Index: Integer; var Value: Single);
begin
 FCriticalSection.Enter;
 try
  if Assigned(FModDelay)
   then FModDelay.Depth := Value;
 finally
  FCriticalSection.Leave;
 end;
end;

procedure TModDelayModule.ParameterRateChange(
  Sender: TObject; const Index: Integer; var Value: Single);
begin
 FCriticalSection.Enter;
 try
  if Assigned(FModDelay)
   then FModDelay.Rate := Value;
 finally
  FCriticalSection.Leave;
 end;
end;

procedure TModDelayModule.ParameterFeedbackChange(
  Sender: TObject; const Index: Integer; var Value: Single);
begin
 FCriticalSection.Enter;
 try
  if Assigned(FModDelay)
   then FModDelay.Feedback := Value;
 finally
  FCriticalSection.Leave;
 end;
end;

procedure TModDelayModule.ParameterDelayChange(
  Sender: TObject; const Index: Integer; var Value: Single);
begin
 FCriticalSection.Enter;
 try
  if Assigned(FModDelay)
   then FModDelay.Delay := Value;
 finally
  FCriticalSection.Leave;
 end;
end;

procedure TModDelayModule.ParameterGainChange(
  Sender: TObject; const Index: Integer; var Value: Single);
begin
 FCriticalSection.Enter;
 try
  FGain := dB_to_Amp(Value);
 finally
  FCriticalSection.Leave;
 end;
end;

procedure TModDelayModule.ParameterLowpassChange(
  Sender: TObject; const Index: Integer; var Value: Single);
begin
 FCriticalSection.Enter;
 try
  if Assigned(FModDelay)
   then FModDelay.LowpassFrequency := Value;
 finally
  FCriticalSection.Leave;
 end;
end;

procedure TModDelayModule.ParameterLowpassLabel(
  Sender: TObject; const Index: Integer; var PreDefined: AnsiString);
var
  Freq: Single;
begin
 Freq := FModDelay.LowpassFrequency;
 if Freq < 1000
  then PreDefined := 'Hz' else
 if Freq <= 20000
  then PreDefined := 'kHz'
  else PreDefined := '';
end;

procedure TModDelayModule.ParameterLowpassDisplay(
  Sender: TObject; const Index: Integer; var PreDefined: AnsiString);
var
  Freq: Single;
begin
 Freq := FModDelay.LowpassFrequency;
 if Freq < 1000
  then PreDefined := FloatToAnsiString(Freq, 3) else
 if Freq < 20000
  then PreDefined := FloatToAnsiString(0.001 * Freq, 3)
  else PreDefined := 'off';
end;

procedure TModDelayModule.VSTModuleSampleRateChange(Sender: TObject;
  const SampleRate: Single);
begin
 FCriticalSection.Enter;
 try
  if Abs(SampleRate) > 0 then
   if Assigned(FModDelay)
    then FModDelay.Samplerate := Abs(SampleRate);
 finally
  FCriticalSection.Leave;
 end;
end;

procedure TModDelayModule.VSTModuleProcess(const Inputs,
  Outputs: TDAVArrayOfSingleFixedArray; const SampleFrames: Cardinal);
var
  Sample : Integer;
begin
 FCriticalSection.Enter;
 try
  for Sample := 0 to SampleFrames - 1
   do Outputs[0, Sample] := FModDelay.ProcessSample32(FGain * Inputs[0, Sample]);
 finally
  FCriticalSection.Leave;
 end;
end;

end.
