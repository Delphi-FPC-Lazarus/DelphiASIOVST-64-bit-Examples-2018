unit URMCSunriseFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,URMCSunrisePERF,URMCSunriseControlPanel,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,URMCSunriseLFO, URMCSunriseOSC, URMCSunriseVCF,URMCSunriseVCA;

type
  TRMCSunriseFrame = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FPanels:array[0..8] of TRMCSunriseControlPanel;
    procedure CBUIChanged(Sender: TObject; Index, Value: Integer);
  public
    { Public declarations }
    { property } OnUIChanged:TOnUIChanged;
    procedure ChangePCC(pcc,Value: Integer);
  end;

var
  RMCSunriseFrame: TRMCSunriseFrame;

implementation

{$R *.dfm}

procedure TRMCSunriseFrame.ChangePCC(pcc, Value: Integer);
VAR i:integer;
begin
  for i:=0 to 8 do
    FPanels[i].ChangePCC(pcc,value);
end;

procedure TRMCSunriseFrame.FormCreate(Sender: TObject);
VAR i,w,h,dx,dy:integer;
begin
  dx:=12;
  dy:=12;
  for i:=0 to 3 do
  begin
    FPanels[i]:=TRMCSunriseOSC.Create(self,i);
    FPanels[i].Parent:=self;
    w:=FPanels[i].Width;
    h:=FPanels[i].Height;
    FPanels[i].Left:=dx + (i MOD 2)*(dx+w) ;
    FPanels[i].Top :=dy + (i DIV 2)*(dy+h) ;
  end;
  for i:=0 to 1 do
  begin
    FPanels[4+i]:=TRMCSunriseLFO.Create(self,i);
    FPanels[4+i].Parent:=self;
    FPanels[4+i].Left:=dx + i * (dx+w);
    FPanels[4+i].Top:=dy + 2 * (dy+h);
  end;
  FPanels[6]:=TRMCSunriseVCF.Create(self);
  FPanels[6].Parent:=self;
  FPanels[6].Left:=dx + 2*(dy+w) ;
  FPanels[6].Top :=dy;
  FPanels[7]:=TRMCSunriseVCA.Create(self);
  FPanels[7].Parent:=self;
  FPanels[7].Left:=dx + 2*(dy+w) ;
  FPanels[7].Top :=dy + (dy+h);
  FPanels[8]:=TRMCSunrisePERF.Create(self);
  FPanels[8].Parent:=self;
  FPanels[8].Left:=dx + 2*(dx+w) ;
  FPanels[8].Top :=dy + 2*(dy+h);
  ClientWidth:=FPanels[8].Left+FPanels[8].Width+dx;
  ClientHeight:=FPanels[8].Top+FPanels[8].Height+dy;
  for i:=0 to 8 do
    FPanels[i].OnUIChanged:=CBUIChanged;
end;

procedure TRMCSunriseFrame.CBUIChanged( Sender: TObject; Index, Value: Integer);
begin
  if assigned(OnUIChanged) then
    OnUIChanged(Sender,Index,Value);
end;

end.
