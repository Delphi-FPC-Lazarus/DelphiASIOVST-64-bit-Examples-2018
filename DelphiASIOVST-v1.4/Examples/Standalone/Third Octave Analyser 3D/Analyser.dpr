program Analyser;

uses
  FastMM4,  // either download the library or comment if there is an error here
  {$IFDEF UseFastMove}
  FastMove,
  {$ENDIF}
  {$IFDEF UseMadExcept}
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  {$ENDIF}
  Forms,
  AnalyserForm in 'AnalyserForm.pas' {FmASIO};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Third-Octave ASIO Analyser';
  Application.CreateForm(TFmAnalyser, FmAnalyser);
  Application.Run;
end.
