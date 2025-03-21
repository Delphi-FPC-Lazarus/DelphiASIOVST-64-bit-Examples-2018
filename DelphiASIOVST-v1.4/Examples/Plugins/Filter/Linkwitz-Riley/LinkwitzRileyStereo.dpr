{$J-,H+,T-P+,X+,B-,V-,O+,A+,W-,U-,R-,I-,Q-,D-,L-,Y-,C-}
library LinkwitzRileyStereo;

uses
  Forms,
  DAV_VSTEffect,
  DAV_VSTBasicModule,
  LinkwitzRileyDM in 'LinkwitzRileyDM.pas' {LinkwitzRileyModule: TVSTModule};

function VstPluginMain(AudioMasterCallback: TAudioMasterCallbackFunc): PVSTEffect; cdecl; export;
begin
  Result := VstModuleMain(AudioMasterCallback, TLinkwitzRileyModule);
end;

exports 
  VstPluginMain name 'main',
  VstPluginMain name 'VSTPluginMain';

begin
end.
