program prjModularView;

uses
  Vcl.Forms,
  UModularViewTestMain in 'UModularViewTestMain.pas' {Form1},
  URMCEmptyPanel in '..\..\Components\RMC\URMCEmptyPanel.pas',
  URMCControls in '..\..\Components\RMC\URMCControls.pas',
  URMCConstants in '..\..\Components\RMC\URMCConstants.pas',
  URMCBaseControlPanel in '..\..\Components\RMC\URMCBaseControlPanel.pas',
  UKnobEditor in '..\..\Components\RMC\UKnobEditor.pas',
  URMCShape in '..\..\Components\RMC\URMCShape.pas',
  URMCModularView in 'URMCModularView.pas',
  UVirtCC in '..\..\Common\UVirtCC.pas',
  UMidiPorts in '..\..\Common\UMidiPorts.pas',
  UMidiEvent in '..\..\Common\UMidiEvent.pas',
  UMidiNrpn in '..\..\Common\UMidiNrpn.pas',
  MidiBase in '..\..\Common\MidiBase.pas',
  URMCVSTView in '..\URMCVSTView.pas',
  UTickCount in '..\..\..\Common\UTickCount.pas',
  URMCBitmaps in '..\..\Components\RMC\URMCBitmaps.pas',
  URMC7Segment in '..\..\Components\RMC\URMC7Segment.pas',
  URMCSunriseControlPanel in 'URMCSunriseControlPanel.pas',
  URMCSunriseFrame in 'URMCSunriseFrame.pas' {RMCSunriseFrame},
  URMCSunriseLFO in 'URMCSunriseLFO.pas' {RMCSunriseLFOFrame},
  URMCSunriseOSC in 'URMCSunriseOSC.pas' {RMCSunriseOSCFrame},
  URMCSunrisePERF in 'URMCSunrisePERF.pas' {RMCSunrisePERFFrame},
  URMCSunriseVCA in 'URMCSunriseVCA.pas' {RMCSunriseVCAFrame},
  URMCSunriseVCF in 'URMCSunriseVCF.pas' {RMCSunriseVCFFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
