unit dlgDetallesHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TdlgDetallesHistorico = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    lblOperacion: TLabel;
    Label2: TLabel;
    lblPercha: TLabel;
    Label3: TLabel;
    lblEntrada: TLabel;
    Label4: TLabel;
    lblRetirada: TLabel;
    Label5: TLabel;
    lblImporte: TLabel;
    Label6: TLabel;
    lblCobrado: TLabel;
    Label7: TLabel;
    lblHash: TLabel;
    btnRecuperar: TButton;
    btnCancel: TButton;
    Label8: TLabel;
    lblMovimiento: TLabel;
    procedure btnRecuperarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FNumOperacion: string;
    FCodigoPercha: string;
    FHash: string;
    FCodigoRandom: string;
    FFechaEntrada: string;
    FImporteCobrado: string;
    FCobrado: Integer;
    FFechaRetirada: string;
    FFechaMovimiento: string;
    
    FOnRecuperar: TNotifyEvent;
    
    procedure SetDatos(const AOperacion, APercha, AHash, ARandom, 
      AFechaEntrada, AImporte, ACobrado, AFechaRetirada, AFechaMovimiento: string);
  public
    property OnRecuperar: TNotifyEvent read FOnRecuperar write FOnRecuperar;
    property NumOperacion: string read FNumOperacion;
    property CodigoPercha: string read FCodigoPercha;
    property Hash: string read FHash;
    property CodigoRandom: string read FCodigoRandom;
    property FechaEntrada: string read FFechaEntrada;
    property ImporteCobrado: string read FImporteCobrado;
    property Cobrado: Integer read FCobrado;
    property FechaRetirada: string read FFechaRetirada;
    property FechaMovimiento: string read FFechaMovimiento;
    
    procedure MostrarDatos(const AOperacion, APercha, AHash, ARandom, 
      AFechaEntrada, AImporte, ACobrado, AFechaRetirada, AFechaMovimiento: string);
  end;

implementation

{$R *.dfm}

procedure TdlgDetallesHistorico.btnRecuperarClick(Sender: TObject);
begin
  if Assigned(FOnRecuperar) then
    FOnRecuperar(Self);
end;

procedure TdlgDetallesHistorico.FormCreate(Sender: TObject);
begin
  // Centrar el formulario
  Position := poMainFormCenter;
end;

procedure TdlgDetallesHistorico.MostrarDatos(const AOperacion, APercha, AHash, ARandom,
  AFechaEntrada, AImporte, ACobrado, AFechaRetirada, AFechaMovimiento: string);
begin
  SetDatos(AOperacion, APercha, AHash, ARandom, AFechaEntrada, AImporte, 
           ACobrado, AFechaRetirada, AFechaMovimiento);
end;

procedure TdlgDetallesHistorico.SetDatos(const AOperacion, APercha, AHash, ARandom,
  AFechaEntrada, AImporte, ACobrado, AFechaRetirada, AFechaMovimiento: string);
begin
  FNumOperacion := AOperacion;
  FCodigoPercha := APercha;
  FHash := AHash;
  FCodigoRandom := ARandom;
  FFechaEntrada := AFechaEntrada;
  FImporteCobrado := AImporte;
  FCobrado := StrToIntDef(ACobrado, 0);
  FFechaRetirada := AFechaRetirada;
  FFechaMovimiento := AFechaMovimiento;

  // Actualizar labels
  lblOperacion.Caption := FNumOperacion;
  lblPercha.Caption := FCodigoPercha;
  lblHash.Caption := FHash;
  lblEntrada.Caption := FFechaEntrada;
  lblRetirada.Caption := FFechaRetirada;
  lblMovimiento.Caption := FFechaMovimiento;
  lblImporte.Caption := Format('%.2f €', [StrToFloatDef(FImporteCobrado, 0)]);

  // Corrección aquí:
  if FCobrado = 1 then
    lblCobrado.Caption := 'Sí'
  else
    lblCobrado.Caption := 'No';
end;
end.