unit ASIOMP3VSTSetup;

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
//  Portions created by Christian-W. Budde are Copyright (C) 2007-2012        //
//  by Christian-W. Budde. All Rights Reserved.                               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

interface

{$I ..\DAV_Compiler.inc}

uses
  {$IFDEF FPC} LCLIntf, LResources, {$ELSE} Windows, Messages, {$ENDIF}
  SysUtils, Classes, Controls, Forms, StdCtrls;

type
  TFmSetup = class(TForm)
    LbPreset: TLabel;
    LbOutput: TLabel;
    CbDrivers: TComboBox;
    CBOutput: TComboBox;
    BtControlPanel: TButton;
    procedure CbDriversChange(Sender: TObject);
    procedure CBOutputChange(Sender: TObject);
    procedure BtControlPanelClick(Sender: TObject);
  end;

var
  FmSetup: TFmSetup;

implementation

uses
  IniFiles, ASIOMP3VSTGUI;

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

procedure TFmSetup.BtControlPanelClick(Sender: TObject);
begin
 FmASIOMP3VST.AsioHost.ControlPanel;
end;

procedure TFmSetup.CbDriversChange(Sender: TObject);
var
  i : Integer;
begin
 with FmASIOMP3VST.ASIOHost do
  if CBDrivers.ItemIndex >= 0 then
   begin
    Active := False;
    DriverIndex := CBDrivers.ItemIndex;
    CBOutput.Clear;
    for i := 0 to (OutputChannelCount div 2) - 1 do
     begin
      CBOutput.Items.Add(string(
        OutputChannelInfos[2 * i].name + ' / ' +
        OutputChannelInfos[2 * i + 1].name));
     end;
    CBOutput.ItemIndex := 0;
    if Assigned(OnReset)
     then OnReset(Self);
    Active := True;
   end;
end;

procedure TFmSetup.CBOutputChange(Sender: TObject);
begin
 FmASIOMP3VST.OutputChannelOffset := CBOutput.ItemIndex * 2;
end;

{$IFDEF FPC}
initialization
  {$i EditorSetup.lrs}
{$ENDIF}

end.

