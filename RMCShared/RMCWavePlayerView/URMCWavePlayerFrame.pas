unit URMCWavePlayerFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, URMCControls,
  URMCEmptyPanel;

type
  TOnUIChanged = procedure ( Sender: TObject; Index, Value: Integer) of object;

  TRMCWavePlayerFrame = class(TForm)
    RMCEmptyPanel1: TRMCEmptyPanel;
    ButtonPlay: TButton;
    ButtonPause: TButton;
    LabelFilename: TLabel;
    LabelStatus: TLabel;
    Panel1: TPanel;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    FHandler: TNotifyEvent;
  public
    { Public declarations }
    procedure setClickHandler(handler:TNotifyEvent);
  end;

var
  RMCWavePlayerFrame: TRMCWavePlayerFrame;

implementation

{$R *.dfm}

procedure TRMCWavePlayerFrame.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FHandler(NIL);
end;

procedure TRMCWavePlayerFrame.Panel1MouseDown(Sender: TObject;  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FHandler(NIL);
end;

procedure TRMCWavePlayerFrame.setClickHandler(handler: TNotifyEvent);
begin
  FHandler:=handler;
end;

end.
