program prjCrumarView;

uses
  Vcl.Forms,
  UCrumarViewTestMain in 'UCrumarViewTestMain.pas' {Form1},
  URMCEmptyPanel in '..\..\Components\RMC\URMCEmptyPanel.pas',
  URMCControls in '..\..\Components\RMC\URMCControls.pas',
  URMCConstants in '..\..\Components\RMC\URMCConstants.pas',
  URMCBaseControlPanel in '..\..\Components\RMC\URMCBaseControlPanel.pas',
  UKnobEditor in '..\..\Components\RMC\UKnobEditor.pas',
  URMCShape in '..\..\Components\RMC\URMCShape.pas',
  URMCVSTView in '..\URMCVSTView.pas',
  UCrumarViewFrame in 'UCrumarViewFrame.pas' {CrumarViewFrame: TFrame},
  UVirtCC in '..\..\Common\UVirtCC.pas',
  UMidiPorts in '..\..\Common\UMidiPorts.pas',
  UMidiEvent in '..\..\Common\UMidiEvent.pas',
  UMidiNrpn in '..\..\Common\UMidiNrpn.pas',
  MidiBase in '..\..\Common\MidiBase.pas',
  URMCBitmaps in '..\..\Components\RMC\URMCBitmaps.pas' {RMCBitmaps},
  URMC7Segment in '..\..\Components\RMC\URMC7Segment.pas',
  URMCCrumarView in 'URMCCrumarView.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
