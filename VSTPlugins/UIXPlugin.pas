unit UIXPlugin;

interface

uses DAV_Types,DAV_VSTEffect,Classes,Forms,UMidiEvent;

type IXPlugin = interface
      procedure SetEditor(form:TForm);
      procedure AddParameters;
      procedure SetSlider(index,value:integer);
      procedure ShowEffects;
      procedure Process(const Inputs,Outputs: TDAVArrayOfSingleFixedArray; const SampleFrames: Cardinal);
      procedure SetSampleRate(rate:single);
      procedure OnParameterChanged(Sender: TObject; const Index,Value: Integer);
      function ParamCount:integer;
      procedure Close;
      procedure SetTempo(tempo:single);
      procedure ProcessMidi(Sender: TObject; MidiEvent: TMidiEvent);
      procedure LoadFromStream(stream: TMemoryStream; index: integer; isPreset: boolean);
      procedure SaveToStream(stream: TMemoryStream; index: integer;   isPreset: boolean);
      function GetFormClass:TFormClass;
    end;

type TWriteMidiEvent = procedure (const m:TMidiEvent) of object;
type IXMidiPlugin = interface
      procedure SetEditor(form:TForm);
      procedure OnParameterChanged(Sender: TObject; const Index,Value: Integer);
      function ParamCount:integer;
      procedure Close;
      procedure SetTempo(tempo:single);
      procedure ProcessMidi(Sender: TObject; MidiEvent: TVstMidiEvent);
      procedure LoadFromStream(stream: TMemoryStream; index: integer; isPreset: boolean);
      procedure SaveToStream(stream: TMemoryStream; index: integer;   isPreset: boolean);
      function GetFormClass:TFormClass;
      procedure SetWriteMidiEventProc(proc:TWriteMidiEvent);
      procedure WriteMidiEvent(const m:TMidiEvent);
    end;


implementation

end.
