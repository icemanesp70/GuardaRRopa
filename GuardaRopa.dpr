program GuardaRopa;

uses
  Vcl.Forms,
  main in 'main.pas' {frmMain},
  dlgAsignarPercha in 'dlgAsignarPercha.pas' {frmAsignarPercha},
  DelphiZXIngQRCode in '..\Libs\DelphiZXIngQRCode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  //Application.CreateForm(TfrmAsignarPercha, frmAsignarPercha);
  Application.Run;
end.
