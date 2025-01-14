unit UModularViewTestMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,URMCModularView, Vcl.StdCtrls,UMidiPorts,UMidiEvent,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    PanelModularView: TPanel;
    PanelControl: TPanel;
    Memo1: TMemo;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    MidiOutPort:TMidiOutPort;
    FModularView:TRMCModularView;
    procedure OnPCCChanged(Sender: TObject; Index, Value: Integer);
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses UVirtCC;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FModularView.ChangePCC(11,81);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Left:=2000;
  MidiOutPort:=TMidiOutPort.Create;
  MidiOutPort.Open('Super52 Out-01-16');
  FModularView:=TRMCModularView.Create(PanelModularView);
  with FModularView do
  begin
    Parent:=PanelModularView;
    Visible:=true;
    OnPCCChanged:=self.OnPCCChanged;
    PanelModularView.Width:=Width;
    PanelModularView.Height:=Height;
  end;
  ClientWidth:=PanelModularView.Width;
  ClientHeight:=PanelModularView.Height+PanelControl.Height;
end;

procedure TForm1.OnPCCChanged(Sender:TObject;Index,Value: Integer);
begin
  Memo1.Lines.Add('PCC Changed: '+inttostr(index)+' '+inttostr(value));
  MidiOutPort.WriteMidi(MidiEvent(0,MIDI_CC,index,value));
end;


end.
