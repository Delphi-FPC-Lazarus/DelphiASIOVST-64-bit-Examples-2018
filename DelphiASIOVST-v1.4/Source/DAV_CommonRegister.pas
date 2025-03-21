{******************************************************************************}
{                                                                              }
{  Version: MPL 1.1 or LGPL 2.1 with linking exception                         }
{                                                                              }
{  The contents of this file are subject to the Mozilla Public License         }
{  Version 1.1 (the "License"); you may not use this file except in            }
{  compliance with the License. You may obtain a copy of the License at        }
{  http://www.mozilla.org/MPL/                                                 }
{                                                                              }
{  Software distributed under the License is distributed on an "AS IS"         }
{  basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the     }
{  License for the specific language governing rights and limitations under    }
{  the License.                                                                }
{                                                                              }
{  Alternatively, the contents of this file may be used under the terms of     }
{  the Free Pascal modified version of the GNU Lesser General Public           }
{  License Version 2.1 (the "FPC modified LGPL License"), in which case the    }
{  provisions of this license are applicable instead of those above.           }
{  Please see the file LICENSE.txt for additional information concerning       }
{  this license.                                                               }
{                                                                              }
{  The code is part of the Delphi ASIO & VST Project                           }
{                                                                              }
{  The initial developer of this code is Christian-W. Budde                    }
{                                                                              }
{  Portions created by Christian-W. Budde are Copyright (C) 2003-2012          }
{  by Christian-W. Budde. All Rights Reserved.                                 }
{                                                                              }
{******************************************************************************}

unit DAV_CommonRegister;

interface

{$I DAV_Compiler.inc}

procedure Register;

implementation

{$IFNDEF FPC}{$R ..\..\Resources\DAV_CommonRegister.res}{$ENDIF}

uses
  {$IFDEF FPC} LResources, {$ENDIF} {$IFNDEF FPC} DAV_MidiFile, {$ENDIF}
  Classes, DAV_Common, DAV_SampleRateSource, DAV_AudioData, DAV_ComplexData,
  DAV_ProcessorInfoComponent;

procedure Register;
begin
  RegisterComponents('ASIO/VST Basics', [{$IFNDEF FPC} TMidiFile, {$ENDIF}
    TSampleRateSource, TAudioData32Component, TAudioData64Component,
    TComplexData32, TComplexData64, TAudioDataCollection32,
    TAudioDataCollection64, TProcessorInfoComponent]);
end;

end.
