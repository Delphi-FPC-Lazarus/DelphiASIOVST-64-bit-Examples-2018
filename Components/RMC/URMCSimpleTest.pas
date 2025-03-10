unit URMCSimpleTest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, URMCControls, Vcl.StdCtrls,URMCPropertyForm, URMCConstants,
  Vcl.Samples.Spin, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    RMCElement1: TRMCElement;
    Button1: TButton;
    Button2: TButton;
    SpinEdit1: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses UMyScreen;

procedure TForm1.Button1Click(Sender: TObject);
begin
  with TRMCPropertyForm.Create(self) do
  begin
    if Execute(self.RMCElement1) then;
    Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  RMCElement1.Shape:=TRMCKnobShape(ord(RMCElement1.Shape)+1);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
 Left:=2000;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  RMCElement1.Value:=SpinEdit1.Value;
end;

end.
