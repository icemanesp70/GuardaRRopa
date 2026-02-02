unit dlgAsignarPercha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmAsignarPercha = class(TForm)
    Label1: TLabel;
    edPercha: TEdit;
    btnAceptar: TButton;
    btnCancelar: TButton;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edPerchaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FPercha : String;
  public
    { Public declarations }
    property Percha: string read FPercha write FPercha;
  end;

var
  frmAsignarPercha: TfrmAsignarPercha;

implementation

{$R *.dfm}

procedure TfrmAsignarPercha.btnAceptarClick(Sender: TObject);
begin
  FPercha := Trim(edPercha.Text);
  ModalResult := mrOk;
end;

procedure TfrmAsignarPercha.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmAsignarPercha.edPerchaKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, #13, #27]) then
    Key := #0;
  case key of
    #13 : btnAceptar.Click;
    #27 : btnCancelar.Click;
  end;
end;

procedure TfrmAsignarPercha.FormShow(Sender: TObject);
begin
  edPercha.Text := '';
  edPercha.SetFocus;
end;

end.
