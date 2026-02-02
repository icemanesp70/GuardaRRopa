unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Mask, System.IniFiles, System.IOUtils, Vcl.Printers,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Phys.SQLiteWrapper.Stat, Data.DB, Vcl.Grids, System.Hash,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Vcl.DBGrids, DelphiZXingQRCode, Vcl.Imaging.jpeg,
  WinSpool;
type
  TfrmMain = class(TForm)
    PanCabecera: TPanel;
    PanDetalle: TPanel;
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    tabUser: TTabSheet;
    tabControl: TTabSheet;
    pPrincipalTop: TPanel;
    btnEntrada: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    btnCrearDB: TButton;
    Label2: TLabel;
    edRutaDB: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edNombreLocal: TEdit;
    chkMostrarPercha: TCheckBox;
    chkUsarLogo: TCheckBox;
    Label5: TLabel;
    Edit1: TEdit;
    cbImpresoras: TComboBox;
    Label6: TLabel;
    btnPreviewTicket: TButton;
    udCopias: TUpDown;
    Label7: TLabel;
    btnExaminarDB: TButton;
    edCopias: TEdit;
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    btnGuardarConfig: TButton;
    GridPrendas: TDBGrid;
    qryPrendas: TFDQuery;
    dsPrendas: TDataSource;
    Panel3: TPanel;
    edtqr: TEdit;
    btnBuscarHash: TButton;
    Label8: TLabel;
    Label9: TLabel;
    edOperacion: TEdit;
    Label10: TLabel;
    edPercha: TEdit;
    btnBusquedaManual: TButton;
    Label11: TLabel;
    chkCobrar: TCheckBox;
    edImportePorDefecto: TEdit;
    Button1: TButton;
    lblContadorPerchas: TLabel;
    tabHistorico: TTabSheet;
    Panel4: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edQRHistorico: TEdit;
    btnBusquedaQRHist: TButton;
    edOperacionHistorico: TEdit;
    edPerchaHistorico: TEdit;
    btnBusquedaManualHist: TButton;
    Panel5: TPanel;
    GridHistorico: TDBGrid;
    lblInformacion: TLabel;
    qryHistorico: TFDQuery;
    dsHistorico: TDataSource;
    btnRefrescarHistorico: TButton;
    btnRecuperarDelHistorico: TButton;
    chkAutocorte: TCheckBox;
    cbTipoCorte: TComboBox;
    edComandoPersonalizado: TEdit;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCrearDBClick(Sender: TObject);
    procedure btnExaminarDBClick(Sender: TObject);
    procedure edRutaDBChange(Sender: TObject);
    procedure btnGuardarConfigClick(Sender: TObject);
    procedure ConfiguracionCambiada(Sender: TObject);
    procedure chkMostrarPerchaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure btnEntradaClick(Sender: TObject);
    procedure btnBuscarHashClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridPrendasDblClick(Sender: TObject);
    procedure btnBusquedaManualClick(Sender: TObject);
    procedure edOperacionKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure edtqrKeyPress(Sender: TObject; var Key: Char);
    procedure btnBusquedaQRHistClick(Sender: TObject);
    procedure btnBusquedaManualHistClick(Sender: TObject);
    procedure tabHistoricoEnter(Sender: TObject);
    procedure btnRefrescarHistoricoClick(Sender: TObject);
    procedure GridHistoricoDblClick(Sender: TObject);
    procedure chkAutocorteClick(Sender: TObject);

  private
    { Private declarations }

    FConfigFile: string;
    FIniFile: TIniFile;
    FConfiguracionModificada: Boolean;
    FCargandoConfiguracion : Boolean;
    FContadorPerchas: Integer;

    procedure CargarConfig;
    procedure GuardarConfig;
    procedure UpdateStatusBar;
    procedure ListaImpresoras;
    function GetDatabasePath: string;
    procedure CrearDataBase;
    procedure ConectarDataBase;
    function HuboCambios : Boolean;
    procedure AsignarNuevaPrenda(const ACodigoPercha : string);
    function GenerarCodigoRandom(Longitud: Integer): string;
    procedure ActualizarGridPrendas;
    function GenerarNumOperacion: string;
    procedure RenombraColumnasGrid;
    procedure ConfigurarColumnasGrid;
    function GenerarQRyGuardar(const ATexto: string): Boolean;
    procedure ImprimirTickets(const AHash, APercha, ANumOperacion: string; ACopias: Integer = 1);
    procedure ImprimirTicketUnico(const AHash, APercha, ANumOperacion: string);
    function GenerarQRDesdeHash(const ATexto: string): TBitmap;
    procedure ImprimirContenidoTicket(const AHash, APercha, ANumOperacion: string);
    procedure MoverAlHistorico(const AHash: string);
    function ContarPerchasActivas: Integer;
    procedure ActualizarContadorPerchas;
    function ExisteDatabase:Boolean;
    procedure EscribeLog(const NombreFichero, Msg: string);
    procedure Informacion(const Msg: string);
    procedure ConfigurarColumnasHistorico;
    procedure BuscarEnHistoricoPorHash(const AHash: string);
    procedure BuscarEnHistoricoPorCampo(const ACampo, ACriterio: string);
    procedure MostrarTodosHistorico;
    procedure RecuperarDesdeDialogo(Sender: TObject);
    function ObtenerHashDelHistorico(const ANumOperacion: string): string;
    function ObtenerCodigoRandomDelHistorico(const ANumOperacion: string): string;
    procedure EliminarPrendaPorPercha(const ACodigoPercha: string);
    function EsPerchaLibre(const ACodigoPercha: string): Boolean;
    function MoverDelHistoricoAPerchas(const ANumOperacion, ACodigoPercha, AHash,ACodigoRandom, AFechaEntrada,
                                        AImporteCobrado: string; ACobrado: Integer): Boolean;
    function GetAppDataPath: string;
    function GetConfigFilePath: string;
    function ObtenerComandoCorte: RawByteString;
    function HexToBin(const HexStr: string): RawByteString;
    procedure EnviarComandoRaw(const Comando: RawByteString);
    function HexStringToRawByteString(const Hex: string): RawByteString;
    procedure EnviarComandoRawSeguro(const Comando: RawByteString);

  public
    { Public declarations }
  end;

var
  RutaDB, NombreLocal : String;
  MostrarPercha : Boolean;

  frmMain: TfrmMain;


implementation
uses dlgAsignarPercha, dlgDetallesHistorico;


{$R *.dfm}

const
  DEFAULT_DB_NAME = 'perchas.sqlite';

function TfrmMain.HuboCambios: Boolean;
var
  Ini: TIniFile;
  Fichero: string;
begin
  Result := False;
  Fichero := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'config.ini');

  if not FileExists(Fichero) then
    Exit; // Si no existe el INI, consideramos que hay cambios (o no, según criterio)

  Ini := TIniFile.Create(Fichero);
  try
    // Comparar cada valor
    if edRutaDB.Text <> Ini.ReadString('Database', 'RutaDB', DEFAULT_DB_NAME) then
      Exit(True);

    if edNombreLocal.Text <> Ini.ReadString('Ticket', 'NombreLocal', 'GuardaRopa Central') then
      Exit(True);

    if udCopias.Position <> Ini.ReadInteger('Ticket', 'Copias', 2) then
      Exit(True);

    if cbImpresoras.Text <> Ini.ReadString('Ticket', 'Impresora', '') then
      Exit(True);

    if chkMostrarPercha.Checked <> Ini.ReadBool('Ticket', 'MostrarNumeroPercha', True) then
      Exit(True);

    if chkCobrar.Checked <> Ini.ReadBool('Ticket', 'Cobrar', False) then
      Exit(True);

    // Si llegamos aquí, no hay cambios
    Result := False;
  finally
    Ini.Free;
  end;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FConfiguracionModificada then
  begin
    case MessageDlg('Hay cambios en la configuración sin guardar. ¿Desea guardarlos antes de salir?',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          GuardarConfig;
          CanClose := True;
        end;
      mrNo:
        CanClose := True; // salir sin guardar
      mrCancel:
        CanClose := False; // cancelar cierre
    end;
  end
  else
    CanClose := True;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
Var DBPath : String;
begin
  DBPath := GetDatabasePath;
  FConfigFile := GetConfigFilePath;
  FIniFile := TIniFile.Create(FConfigFile);
  //FConfigFile := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'config.ini');
  //FIniFile := TIniFile.Create(FConfigFile);
  FCargandoConfiguracion := True;
  try
    CargarConfig;
    ConectarDataBase;
  finally
    FCargandoConfiguracion := False;
    FConfiguracionModificada := False;
  end;

  // Configurar query con CAST para evitar problemas de tipo en SQLite
  qryPrendas.Connection := FDConnection1;
  qryPrendas.SQL.Text :=
    'SELECT ' +
    '  CAST(num_operacion AS TEXT) AS num_operacion, ' +
    '  CAST(codigo_percha AS TEXT) AS codigo_percha, ' +
    '  CAST(fecha_hora_entrada AS TEXT) AS fecha_hora_entrada ' +
    'FROM Perchas WHERE fecha_hora_retirada IS NULL ' +
    'ORDER BY fecha_hora_entrada DESC';
  try
    DBPath := GetDatabasePath;
    if FileExists(DBPath) then qryPrendas.Open;
  finally
    dsPrendas.DataSet := qryPrendas;
    GridPrendas.DataSource := dsPrendas;
  end;

  // Configurar columnas
  ConfigurarColumnasGrid;

  // Configurar query del histórico
  qryHistorico.Connection := FDConnection1;
  qryHistorico.SQL.Text :=
    'SELECT ' +
    '  CAST(num_operacion AS TEXT) AS num_operacion, ' +
    '  CAST(codigo_percha AS TEXT) AS codigo_percha, ' +
    '  CAST(fecha_hora_entrada AS TEXT) AS fecha_hora_entrada, ' +
    '  CAST(fecha_hora_retirada AS TEXT) AS fecha_hora_retirada, ' +
    '  CAST(importe_cobrado AS REAL) AS importe_cobrado, ' +
    '  CAST(cobrado AS INTEGER) AS cobrado, ' +
    '  CAST(fecha_movimiento AS TEXT) AS fecha_movimiento ' +
    'FROM Historico ' +
    'ORDER BY fecha_movimiento DESC';

  qryHistorico.Open;
  dsHistorico.DataSet := qryHistorico;
  GridHistorico.DataSource := dsHistorico;

  // Configurar columnas del histórico
  ConfigurarColumnasHistorico;

  // Configurar combo de corte
  cbTipoCorte.Items.Add('EPSON - Corte parcial');
  cbTipoCorte.Items.Add('EPSON - Corte completo');
  cbTipoCorte.Items.Add('STAR - Corte parcial');
  cbTipoCorte.Items.Add('STAR - Corte completo');
  cbTipoCorte.Items.Add('Personalizado');
  cbTipoCorte.ItemIndex := 0;

  // Evento para habilitar campo personalizado
  chkAutocorte.OnClick := chkAutocorteClick;

end;



procedure TfrmMain.FormDestroy(Sender: TObject);
begin
 qryPrendas.Close;
 FDConnection1.Close;
 FIniFile.Free;
end;

procedure TfrmMain.ConfigurarColumnasGrid;
begin
  GridPrendas.Columns.Clear;

  with GridPrendas.Columns.Add do
  begin
    FieldName := 'num_operacion';
    Title.Caption := 'Operación';
    Width := 80;
  end;

  with GridPrendas.Columns.Add do
  begin
    FieldName := 'codigo_percha';
    Title.Caption := 'Percha';
    Width := 70;
  end;

  with GridPrendas.Columns.Add do
  begin
    FieldName := 'fecha_hora_entrada';
    Title.Caption := 'Hora entrada';
    Width := 140;
  end;
end;

procedure TFrmMain.RenombraColumnasGrid;
begin
  if GridPrendas.Columns.Count >= 3 then
  begin
    GridPrendas.Columns[0].Title.Caption := 'Operación';
    GridPrendas.Columns[1].Title.Caption := 'Percha';
    GridPrendas.Columns[2].Title.Caption := 'Hora entrada';
  end;
end;

procedure TfrmMain.tabHistoricoEnter(Sender: TObject);
begin
  MostrarTodosHistorico;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  RenombraColumnasGrid;
  if ExisteDatabase then ActualizarContadorPerchas;
  Informacion('Iniciamos Guardarropa Infosoft...');
end;

function TfrmMain.GetDatabasePath: string;
begin
  Result := TPath.Combine(GetAppDataPath, 'perchas.sqlite');
end;

procedure TfrmMain.GridHistoricoDblClick(Sender: TObject);
var
  dlg: TdlgDetallesHistorico;
  NumOperacion, CodigoPercha, Hash, CodigoRandom: string;
  FechaEntrada, FechaRetirada, ImporteCobrado, FechaMovimiento: string;
  Cobrado: string;
begin
  if qryHistorico.IsEmpty or qryHistorico.Bof or qryHistorico.Eof then
    Exit;

  // Obtener todos los datos
  NumOperacion := qryHistorico.FieldByName('num_operacion').AsString;
  CodigoPercha := qryHistorico.FieldByName('codigo_percha').AsString;
  FechaEntrada := qryHistorico.FieldByName('fecha_hora_entrada').AsString;
  FechaRetirada := qryHistorico.FieldByName('fecha_hora_retirada').AsString;
  ImporteCobrado := qryHistorico.FieldByName('importe_cobrado').AsString;
  Cobrado := IntToStr(qryHistorico.FieldByName('cobrado').AsInteger);
  FechaMovimiento := qryHistorico.FieldByName('fecha_movimiento').AsString;
  Hash := ObtenerHashDelHistorico(NumOperacion);
  CodigoRandom := ObtenerCodigoRandomDelHistorico(NumOperacion);

  // Mostrar diálogo
  dlg := TdlgDetallesHistorico.Create(Self);
  try
    dlg.MostrarDatos(NumOperacion, CodigoPercha, Hash, CodigoRandom,
                     FechaEntrada, ImporteCobrado, Cobrado, FechaRetirada, FechaMovimiento);
    dlg.OnRecuperar := RecuperarDesdeDialogo;

    if dlg.ShowModal = mrOk then
    begin
      // Ya se manejó en RecuperarDesdeDialogo
    end;
  finally
    dlg.Free;
  end;
end;

procedure TfrmMain.GridPrendasDblClick(Sender: TObject);
var
  NumOperacion, CodigoPercha, Hash: string;
  Query: TFDQuery;
begin
  // Verificar que haya un registro actual
  if qryPrendas.RecordCount = 0 then exit;

  (*
  if qryPrendas.Eof or qryPrendas.Bof then
    Exit;
  *)

  // Obtener datos del registro actual
  NumOperacion := qryPrendas.FieldByName('num_operacion').AsString;
  CodigoPercha := qryPrendas.FieldByName('codigo_percha').AsString;

  // Buscar el hash (aunque podríamos obtenerlo directamente si lo incluimos en la consulta)
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDConnection1;
    Query.SQL.Text :=
      'SELECT hash_sha256 FROM Perchas ' +
      'WHERE num_operacion = :num AND fecha_hora_retirada IS NULL';
    Query.ParamByName('num').AsString := NumOperacion;
    Query.Open;

    if Query.Eof then
    begin
      ShowMessage('Operación no encontrada o ya retirada');
      Exit;
    end;

    Hash := Query.FieldByName('hash_sha256').AsString;

    // Confirmar reimprimir
    if MessageDlg('¿Reimprimir ticket de la operación ' + NumOperacion + '?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      ImprimirTickets(Hash, CodigoPercha, NumOperacion, udCopias.Position);
    end;
  finally
    Query.Free;
  end;
end;

procedure TfrmMain.CargarConfig;
var
  DBPath: string;
  ImpresoraGuardada: String;
  i: Integer;
  // Guardar eventos
  GuardarRutaDB, GuardarNombreLocal, GuardarCopias: TNotifyEvent;
begin
  // --- Guardar y desactivar eventos ---
  GuardarRutaDB := edRutaDB.OnChange;
  GuardarNombreLocal := edNombreLocal.OnChange;
  GuardarCopias := edCopias.OnChange;

  edRutaDB.OnChange := nil;
  edNombreLocal.OnChange := nil;
  edCopias.OnChange := nil;

  try
    // --- Base de datos ---
    DBPath := GetDatabasePath;
    edRutaDB.Text := DBPath;

    // --- Ticket ---
    edNombreLocal.Text := FIniFile.ReadString('Ticket', 'NombreLocal', 'GuardaRopa Central');
    chkMostrarPercha.Checked := FIniFile.ReadBool('Ticket', 'MostrarNumeroPercha', True);
    udCopias.Position := FIniFile.ReadInteger('Ticket', 'Copias', 2); // <-- esto cambia edCopias

    // --- Importes a Cobrar ---
    edImportePorDefecto.Text := FloatToStr(FIniFile.ReadFloat('Ticket', 'ImportePorDefecto', 0.0));
    chkCobrar.Checked := FIniFile.ReadBool('Ticket', 'Cobrar', False);

    // --- Impresora ---
    ListaImpresoras;
    ImpresoraGuardada := FIniFile.ReadString('Ticket', 'Impresora', '');
    cbImpresoras.ItemIndex := -1;
    if ImpresoraGuardada <> '' then
    begin
      for i := 0 to cbImpresoras.Items.Count - 1 do
      begin
        if SameText(cbImpresoras.Items[i], ImpresoraGuardada) then
        begin
          cbImpresoras.ItemIndex := i;
          Break;
        end;
      end;
    end;
    if cbImpresoras.ItemIndex = -1 then
      cbImpresoras.ItemIndex := 0;

    // --- Tema de auto-corte y tipos de corte
    chkAutocorte.Checked := FIniFile.ReadBool('Ticket', 'Autocorte', False);
    cbTipoCorte.ItemIndex := FIniFile.ReadInteger('Ticket', 'TipoCorte', 0);
    edComandoPersonalizado.Text := FIniFile.ReadString('Ticket', 'ComandoPersonalizado', '');


  finally
    // --- Restaurar eventos ---
    edRutaDB.OnChange := GuardarRutaDB;
    edNombreLocal.OnChange := GuardarNombreLocal;
    edCopias.OnChange := GuardarCopias;
  end;
end;

procedure TfrmMain.chkAutocorteClick(Sender: TObject);
begin
  cbTipoCorte.Enabled := chkAutocorte.Checked;
  edComandoPersonalizado.Enabled := chkAutocorte.Checked and
                                   (cbTipoCorte.ItemIndex = 4); // Personalizado
  ConfiguracionCambiada(Sender);
end;

procedure TfrmMain.chkMostrarPerchaClick(Sender: TObject);
begin
  ConfiguracionCambiada(Sender);
end;

procedure TfrmMain.GuardarConfig;
begin
  FIniFile.WriteString('Database', 'RutaDB', edRutaDB.Text);
  FIniFile.WriteString('Ticket', 'NombreLocal', edNombreLocal.Text);
  FIniFile.WriteBool('Ticket', 'MostrarNumeroPercha', chkMostrarPercha.Checked);
  FIniFile.WriteInteger('Ticket', 'Copias', udCopias.Position);
  FIniFile.WriteFloat('Ticket', 'ImportePorDefecto', StrToFloatDef(edImportePorDefecto.Text, 0.0));
  FIniFile.WriteBool('Ticket', 'Cobrar', chkCobrar.Checked);
  FIniFile.WriteBool('Ticket', 'Autocorte', chkAutocorte.Checked);
  FIniFile.WriteInteger('Ticket', 'TipoCorte', cbTipoCorte.ItemIndex);
  FIniFile.WriteString('Ticket', 'ComandoPersonalizado', edComandoPersonalizado.Text);

  if cbImpresoras.ItemIndex >= 0 then
    FIniFile.WriteString('Ticket', 'Impresora', cbImpresoras.Text)
  else
    FIniFile.WriteString('Ticket', 'Impresora', '');
end;

procedure TfrmMain.ListaImpresoras;
var
  i: Integer;
  GuardarAlCambiar : TNotifyEvent;
begin
  GuardarAlCambiar := cbImpresoras.OnChange;
  cbImpresoras.OnChange := nil;
  try
    cbImpresoras.Items.Clear;
    for i := 0 to Printer.Printers.Count - 1 do
      cbImpresoras.Items.Add(Printer.Printers[i]);
    if cbImpresoras.Items.Count > 0 then
      cbImpresoras.ItemIndex := 0;
  finally
    cbImpresoras.OnChange := GuardarAlCambiar;
  end;
end;

procedure TfrmMain.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  if (PageControl1.ActivePageIndex = 1) and FConfiguracionModificada then
  begin
    // El usuario está en la pestaña de configuración y quiere salir de ella
    case MessageDlg('¿Guardar cambios en la configuración antes de continuar?',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
          GuardarConfig;
          FConfiguracionModificada := False;
          AllowChange := True;
        end;
      mrNo:
        begin
          FConfiguracionModificada := False; // descartar cambios
          CargarConfig;
          AllowChange := True;
        end;
      mrCancel:
        AllowChange := False;
    end;
  end
  else
    AllowChange := True;
end;

procedure TfrmMain.btnCrearDBClick(Sender: TObject);
begin
  if MessageDlg('¿Crear o reiniciar la base de datos? Se perderán todos los datos actuales.',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    CrearDataBase;
    GuardarConfig; // Guarda la ruta usada
  end;
end;

procedure TfrmMain.ActualizarGridPrendas;
begin
  qryPrendas.Close;
  qryPrendas.SQL.Text :=
    'SELECT ' +
    '  CAST(num_operacion AS TEXT) AS num_operacion, ' +
    '  CAST(codigo_percha AS TEXT) AS codigo_percha, ' +
    '  CAST(fecha_hora_entrada AS TEXT) AS fecha_hora_entrada, ' +
    '  CAST(hash_sha256 AS TEXT) AS hash_sha256 ' +
    'FROM Perchas ' +
    'ORDER BY fecha_hora_entrada DESC';
  qryPrendas.Open;
end;

function TfrmMain.GenerarCodigoRandom(Longitud: Integer): string;
const
  Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
var
  i: Integer;
begin
  Randomize;
  Result := '';
  for i := 1 to Longitud do
    Result := Result + Chars[Random(Length(Chars)) + 1];
end;

function TfrmMain.GenerarNumOperacion: string;
var
  i: Integer;
  NumStr: string;
  Query: TFDQuery;
begin
  for i := 1 to 9999 do
  begin
    NumStr := Format('%.4d', [i]);
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := FDConnection1;
      Query.SQL.Text :=
        'SELECT COUNT(*) FROM Perchas WHERE num_operacion = :num AND fecha_hora_retirada IS NULL';
      Query.ParamByName('num').AsString := NumStr;
      Query.Open;
      if Query.Fields[0].AsInteger = 0 then
      begin
        Result := NumStr;
        Exit;
      end;
    finally
      Query.Free;
    end;
  end;
  raise Exception.Create('No hay números de operación disponibles (9999 prendas activas)');
end;

procedure TfrmMain.AsignarNuevaPrenda(const ACodigoPercha: string);
var
  NumOperacion, CodigoRandom, Hash: string;
  FechaEntradaStr: string; // ← Usamos STRING para la fecha
  Query: TFDQuery;
  ImporteCobrado: Double;
begin
  // 0. Obtener el importe de la configuración
  ImporteCobrado := 0.0;
  if FIniFile.ReadBool('Ticket', 'Cobrar', False) then
    ImporteCobrado := FIniFile.ReadFloat('Ticket', 'ImportePorDefecto', 0.0);


  // 1. Generar valores
  NumOperacion := GenerarNumOperacion;
  CodigoRandom := GenerarCodigoRandom(6);
  FechaEntradaStr := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
  StatusBar1.Panels[1].Text := 'Generando Valores correctos...';

  // 2. Generar hash (¡mismo formato que al retirar!)
  Hash := THashSHA2.GetHashString(FechaEntradaStr + CodigoRandom + ACodigoPercha).ToUpper;
  EscribeLog('Guardarropa.txt','Generado el HASH :['+Hash+'] Para la OPERACION :'+NumOperacion);
  StatusBar1.Panels[1].Text := 'Hash Generado...'+Hash;

  // 3. Generar y guardar el QR en la carpeta del programa !!
  if not GenerarQRyGuardar(Hash) then
  begin
    ShowMessage('Advertencia!!!! No se pudo generar el código QR');
    StatusBar1.Panels[1].Text := 'Problemas al Generar el QR de la Operación';
    //Aquí habrá que decidir qué hacer en caso de crash del programa.. el Hash no se vuelve a crear igual y el QR de después no coincidirá.
    // Mejor será abortar el asunto o generar otro Hash y hacer como que no ha pasado nada.
  end;

  // 4. Insertar en BD
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDConnection1;

    Query.SQL.Text :=
      'INSERT INTO Perchas ' +
      '(num_operacion, codigo_percha, codigo_random, fecha_hora_entrada, hash_sha256, importe_cobrado) ' +
      'VALUES (:num_op, :percha, :rand, :fecha, :hash, :importe)';

    // Asignar parámetros EXACTAMENTE como se nombran en SQL
    Query.ParamByName('num_op').AsString := NumOperacion;
    Query.ParamByName('percha').AsString := ACodigoPercha;
    Query.ParamByName('rand').AsString := CodigoRandom;
    Query.ParamByName('fecha').AsString := FechaEntradaStr;
    Query.ParamByName('hash').AsString := Hash;
    Query.ParamByName('importe').AsFloat := ImporteCobrado;
    // Ejecutar insertar prenda
    Query.ExecSQL;
    StatusBar1.Panels[1].Text := 'Entrada de la operación ['+ NumOperacion +']  con éxito...';

    // Si hay problemas a lo mejor meter aquí un commit, pero de momento lo dejamos.

    ActualizarContadorPerchas;

  finally
    Query.Free;
  end;

  // 5. Imprimir
  ImprimirTickets(Hash, ACodigoPercha, NumOperacion, udCopias.Position);
end;

procedure TfrmMain.btnEntradaClick(Sender: TObject);
var
  dlg: TfrmAsignarPercha;
  Percha: string;
  tmpInt : Integer;
begin
  if not Existedatabase then
  begin
    ShowMessage('No existe la base de datos. Hay que crearla en configuración');
    exit;
  end;
  
  dlg := TfrmAsignarPercha.Create(Self);
  try
    if dlg.ShowModal = mrOk then
    begin
      Percha := Trim(dlg.Percha);
      if Percha = '' then
      begin
        ShowMessage('Debe introducir un número de percha');
        StatusBar1.Panels[1].Text := 'Error al introducir Percha';
        Exit;
      end;
      // Validar que sean 3 dígitos numéricos
      if TryStrToInt(Percha, tmpInt) then
        Percha := Format('%.3d', [tmpInt])
      else
        Percha := '';
      if not (Length(Percha) = 3) or not TryStrToInt(Percha, tmpInt) then
      begin
        ShowMessage('El número de percha debe estar entre 1 y 999');
        StatusBar1.Panels[1].Text := 'Número de digitos Insuficiente';
        Exit;
      end;

      AsignarNuevaPrenda(Percha);
      qryPrendas.Refresh;

      Informacion(Format('Entra la prenda de la percha %s ',[Percha]));

    end;
  finally
    dlg.Free;
  end;
end;

procedure TfrmMain.btnExaminarDBClick(Sender: TObject);
var
  Dir, FileName: string;
begin
  Dir := TPath.GetDirectoryName(GetDatabasePath);
  FileName := TPath.GetFileName(GetDatabasePath);
  with TSaveDialog.Create(nil) do
  try
    Title := 'Guardar base de datos';
    Filter := 'SQLite Database|*.sqlite|Todos los archivos|*.*';
    InitialDir := Dir;
    FileName := FileName;
    if Execute then
      edRutaDB.Text := FileName;
  finally
    Free;
  end;
end;

procedure TfrmMain.btnGuardarConfigClick(Sender: TObject);
begin
  GuardarConfig;
  StatusBar1.Panels[1].Text := 'Configuración guardada.';
  FConfiguracionModificada := False;
  // Opcional: resetear bandera de cambios (ver más abajo)
end;


procedure TfrmMain.btnRefrescarHistoricoClick(Sender: TObject);
begin
  MostrarTodosHistorico;
  edQRHistorico.Text := '';
  edOperacionHistorico.Text := '';
  edPerchaHistorico.Text := '';
  StatusBar1.Panels[1].Text := 'Limpiando filtros en Histórico';
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  if not Existedatabase then
  begin
    ShowMessage('No existe la base de datos. Hay que crearla en configuración');
    exit;
  end;
  ActualizarGridPrendas;
end;



procedure TfrmMain.btnBusquedaManualClick(Sender: TObject);
var
  Criterio: string;
  Campo: string;
  CodigoPercha, NumOperacion, AHash: String;
  ImporteCobrado: Double;
  Cobrado: Boolean;
  Query: TFDQuery;
  tmpInt: Integer;
begin
  // Comprobar que exista el fichero de base de datos
  if not Existedatabase then
  begin
    ShowMessage('No existe la base de datos. Hay que crearla en configuración');
    exit;
  end;

  // Validar entrada
  if Trim(edOperacion.Text) <> '' then
  begin
    Criterio := Trim(edOperacion.Text);
    // Validar que sea numérico y formatear a 4 dígitos
    if not TryStrToInt(Criterio, tmpInt) then
    begin
      ShowMessage('El número de operación debe ser numérico');
      Exit;
    end;
    Criterio := Format('%.4d', [tmpInt]);
    Campo := 'num_operacion';
  end
  else if Trim(edPercha.Text) <> '' then
  begin
    Criterio := Trim(edPercha.Text);
    // Validar que sea numérico y formatear a 3 dígitos
    if not TryStrToInt(Criterio, tmpInt) then
    begin
      ShowMessage('El número de percha debe ser numérico');
      Exit;
    end;
    Criterio := Format('%.3d', [tmpInt]);
    Campo := 'codigo_percha';
  end
  else
  begin
    ShowMessage('Introduzca número de operación o percha');
    Exit;
  end;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDConnection1;
    Query.SQL.Text :=
      'SELECT codigo_percha, num_operacion, importe_cobrado, cobrado, hash_sha256 ' +
      'FROM Perchas WHERE ' + Campo + ' = :valor AND fecha_hora_retirada IS NULL';
    Query.ParamByName('valor').AsString := Criterio;
    Query.Open;

    if Query.Eof then
    begin
      ShowMessage('❌ No se encontró ninguna prenda activa con esos datos');
      Exit;
    end;

    // Obtener datos
    CodigoPercha := Query.FieldByName('codigo_percha').AsString;
    NumOperacion := Query.FieldByName('num_operacion').AsString;
    ImporteCobrado := Query.FieldByName('importe_cobrado').AsFloat;
    Cobrado := Query.FieldByName('cobrado').AsBoolean;
    AHash := Query.FieldByName('hash_sha256').AsString;

    // Confirmar entrega
    if MessageDlg('¿Desea entregar la prenda de la percha ' + CodigoPercha +
                  ' (Operación ' + NumOperacion + ') ?',
                  mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    begin
      Exit;
    end;

    // Verificar si hay que cobrar
    if (ImporteCobrado > 0) and not Cobrado then
    begin
      if MessageDlg(Format('Importe a cobrar: %.2f €'#13#10'¿Ha sido cobrado?', [ImporteCobrado]),
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        // Marcar como cobrado ANTES de mover al histórico
        FDConnection1.ExecSQL(
          'UPDATE Perchas SET cobrado = 1 WHERE hash_sha256 = :hash',
          [AHash]
        );
      end;
    end;

    // Mover al histórico (esta función ya maneja todo)
    MoverAlHistorico(AHash);

    ShowMessage(Format('[V] Entregue la prenda de la percha %s (Operación %s)',
      [CodigoPercha, NumOperacion]));

    Informacion(Format('Entregando la prenda de la percha %s (Operación %s)',
      [CodigoPercha, NumOperacion]));

    // Limpiar campos y actualizar grid
    edOperacion.Text := '';
    edPercha.Text := '';
    ActualizarGridPrendas;
    edtQR.SetFocus;

  finally
    Query.Free;
  end;
end;



procedure TfrmMain.btnBusquedaManualHistClick(Sender: TObject);
var
  Criterio: string;
  Campo: string;
  tmpInt: Integer;
begin
  if Trim(edOperacionHistorico.Text) <> '' then
  begin
    Criterio := Trim(edOperacionHistorico.Text);
    if not TryStrToInt(Criterio, tmpInt) then
    begin
      ShowMessage('El número de operación debe ser numérico');
      Exit;
    end;
    Criterio := Format('%.4d', [tmpInt]);
    Campo := 'num_operacion';
  end
  else if Trim(edPerchaHistorico.Text) <> '' then
  begin
    Criterio := Trim(edPerchaHistorico.Text);
    if not TryStrToInt(Criterio, tmpInt) then
    begin
      ShowMessage('El número de percha debe ser numérico');
      Exit;
    end;
    Criterio := Format('%.3d', [tmpInt]);
    Campo := 'codigo_percha';
  end
  else
  begin
    ShowMessage('Introduzca número de operación o percha');
    Exit;
  end;

  BuscarEnHistoricoPorCampo(Campo, Criterio);
end;

procedure TfrmMain.BuscarEnHistoricoPorCampo(const ACampo, ACriterio: string);
begin
  qryHistorico.Close;
  qryHistorico.SQL.Text :=
    'SELECT ' +
    '  CAST(num_operacion AS TEXT) AS num_operacion, ' +
    '  CAST(codigo_percha AS TEXT) AS codigo_percha, ' +
    '  CAST(fecha_hora_entrada AS TEXT) AS fecha_hora_entrada, ' +
    '  CAST(fecha_hora_retirada AS TEXT) AS fecha_hora_retirada, ' +
    '  CAST(importe_cobrado AS REAL) AS importe_cobrado, ' +
    '  CAST(cobrado AS INTEGER) AS cobrado, ' +
    '  CAST(fecha_movimiento AS TEXT) AS fecha_movimiento ' +
    'FROM Historico ' +
    'WHERE ' + ACampo + ' = :valor ' +
    'ORDER BY fecha_movimiento DESC';
  qryHistorico.ParamByName('valor').AsString := ACriterio;
  qryHistorico.Open;

  if qryHistorico.IsEmpty then
  begin
    ShowMessage('❌ No se encontró ningún registro con esos datos en el histórico');
    // Mostrar todos los registros
    qryHistorico.Close;
    qryHistorico.SQL.Text :=
      'SELECT ' +
      '  CAST(num_operacion AS TEXT) AS num_operacion, ' +
      '  CAST(codigo_percha AS TEXT) AS codigo_percha, ' +
      '  CAST(fecha_hora_entrada AS TEXT) AS fecha_hora_entrada, ' +
      '  CAST(fecha_hora_retirada AS TEXT) AS fecha_hora_retirada, ' +
      '  CAST(importe_cobrado AS REAL) AS importe_cobrado, ' +
      '  CAST(cobrado AS INTEGER) AS cobrado, ' +
      '  CAST(fecha_movimiento AS TEXT) AS fecha_movimiento ' +
      'FROM Historico ' +
      'ORDER BY fecha_movimiento DESC';
    qryHistorico.Open;
  end;

  edOperacionHistorico.Text := '';
  edPerchaHistorico.Text := '';
  edOperacionHistorico.SetFocus;
end;

procedure TfrmMain.btnBusquedaQRHistClick(Sender: TObject);
var
  Hash: string;
begin
  Hash := Trim(edQRHistorico.Text);
  if Hash = '' then
  begin
    ShowMessage('Introduzca el código QR o hash');
    Exit;
  end;

  BuscarEnHistoricoPorHash(Hash);
end;

procedure TfrmMain.BuscarEnHistoricoPorHash(const AHash: string);
begin
  qryHistorico.Close;
  qryHistorico.SQL.Text :=
    'SELECT ' +
    '  CAST(num_operacion AS TEXT) AS num_operacion, ' +
    '  CAST(codigo_percha AS TEXT) AS codigo_percha, ' +
    '  CAST(fecha_hora_entrada AS TEXT) AS fecha_hora_entrada, ' +
    '  CAST(fecha_hora_retirada AS TEXT) AS fecha_hora_retirada, ' +
    '  CAST(importe_cobrado AS REAL) AS importe_cobrado, ' +
    '  CAST(cobrado AS INTEGER) AS cobrado, ' +
    '  CAST(fecha_movimiento AS TEXT) AS fecha_movimiento ' +
    'FROM Historico ' +
    'WHERE hash_sha256 = :hash ' +
    'ORDER BY fecha_movimiento DESC';
  qryHistorico.ParamByName('hash').AsString := AHash;
  qryHistorico.Open;

  if qryHistorico.IsEmpty then
  begin
    ShowMessage('❌ No se encontró ningún registro con ese hash en el histórico');
    // Mostrar todos los registros
    qryHistorico.Close;
    qryHistorico.SQL.Text :=
      'SELECT ' +
      '  CAST(num_operacion AS TEXT) AS num_operacion, ' +
      '  CAST(codigo_percha AS TEXT) AS codigo_percha, ' +
      '  CAST(fecha_hora_entrada AS TEXT) AS fecha_hora_entrada, ' +
      '  CAST(fecha_hora_retirada AS TEXT) AS fecha_hora_retirada, ' +
      '  CAST(importe_cobrado AS REAL) AS importe_cobrado, ' +
      '  CAST(cobrado AS INTEGER) AS cobrado, ' +
      '  CAST(fecha_movimiento AS TEXT) AS fecha_movimiento ' +
      'FROM Historico ' +
      'ORDER BY fecha_movimiento DESC';
    qryHistorico.Open;
  end;

  edQRHistorico.Text := '';
  edQRHistorico.SetFocus;
end;

procedure TfrmMain.btnBuscarHashClick(Sender: TObject);
var
  Hash: string;
  Query: TFDQuery;
  CodigoPercha, NumOperacion: string;
  ImporteCobrado: Double;
  Cobrado: Boolean;
begin
    if not Existedatabase then
  begin
    ShowMessage('No existe la base de datos. Hay que crearla en configuración');
    exit;
  end;

  StatusBar1.Panels[1].Text := 'Buscando la operación...';
  Hash := Trim(edtQR.Text);
  if Hash = '' then Exit;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDConnection1;
    Query.SQL.Text :=
      'SELECT codigo_percha, num_operacion, importe_cobrado, cobrado ' +
      'FROM Perchas WHERE hash_sha256 = :hash';
    Query.ParamByName('hash').AsString := Hash;
    Query.Open;
    if Query.Eof then
    begin
      ShowMessage('❌ Ticket no válido o ya entregado');
      StatusBar1.Panels[1].Text := 'La Operación ha dado como resultado un TICKET NO VALIDO';
      Exit;
    end;

    CodigoPercha := Query.FieldByName('codigo_percha').AsString;
    NumOperacion := Query.FieldByName('num_operacion').AsString;
    ImporteCobrado := Query.FieldByName('importe_cobrado').AsFloat;
    Cobrado := Query.FieldByName('cobrado').AsBoolean;

    // Aquí miramos la cuestión del cobro
    if (ImporteCobrado > 0) and not Cobrado then
    begin
      if MessageDlg(Format('Importe a cobrar: %.2f €'#13#10'¿Ha sido cobrado?', [ImporteCobrado]),
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        // Marcar como cobrado
        FDConnection1.ExecSQL(
          'UPDATE Perchas SET cobrado = 1 WHERE hash_sha256 = :hash',
          [Hash]
        );
      end;
    end;

    // Mover al histórico y entregar
    MoverAlHistorico(Hash);

    ShowMessage(Format('[V] Entregue la prenda de la percha %s (Operación %s)',
      [CodigoPercha, NumOperacion]));

    Informacion(Format('Entregando la prenda de la percha %s (Operación %s)',
      [CodigoPercha, NumOperacion]));

    ActualizarGridPrendas;

    StatusBar1.Panels[1].Text := 'La prenda [ '+Query.FieldByName('num_operacion').asString+'] ha sido entregada correctamente.';
  finally
    Query.Free;
  end;
  edtQR.Text := '';
  edtQR.SetFocus;
end;

procedure TfrmMain.ConectarDataBase;
var
  DBPath: string;
begin
  try
    FDConnection1.Close;
    DBPath := GetDatabasePath;
    FDConnection1.Params.Values['Database'] := DBPath;
    if not FileExists(DBPath) then
    begin
      ShowMessage('No existe la base de Datos. Debe ir a Configuración y Crear la Base de Datos');
      exit;
    end;
    FDConnection1.Open;
    FDConnection1.TxOptions.AutoCommit := True;
    UpdateStatusBar;
  except
    on E: Exception do
    begin
      StatusBar1.Panels[0].Text := 'Error BD: ' + E.Message;
      StatusBar1.Panels[1].Text := '';
    end;
  end;
end;

procedure TfrmMain.UpdateStatusBar;
begin
  if FDConnection1.Connected then
    StatusBar1.Panels[0].Text := 'Conectado a: ' + ExtractFileName(GetDatabasePath)
  else
    StatusBar1.Panels[0].Text := 'Desconectado';
  StatusBar1.Panels[1].Text := '';
end;

procedure TfrmMain.CrearDataBase;
var
  DBPath: string;
begin
  DBPath := GetDatabasePath;
  TDirectory.CreateDirectory(TPath.GetDirectoryName(DBPath));

  FDConnection1.Close;
  FDConnection1.Params.Values['Database'] := DBPath;
  FDConnection1.Open;

  // Tabla de prendas activas
  FDConnection1.ExecSQL(
    'CREATE TABLE IF NOT EXISTS Perchas (' +
    '  id INTEGER PRIMARY KEY AUTOINCREMENT,' +
    '  num_operacion TEXT NOT NULL,' +
    '  codigo_percha TEXT NOT NULL,' +
    '  codigo_random TEXT NOT NULL,' +
    '  fecha_hora_entrada TEXT NOT NULL,' +
    '  hash_sha256 TEXT NOT NULL UNIQUE,' +
    '  fecha_hora_retirada TEXT,' +
    '  importe_cobrado REAL DEFAULT 0.0,' +
    '  cobrado BOOLEAN DEFAULT 0' +
    ');'
  );

  // Tabla de histórico
  FDConnection1.ExecSQL(
    'CREATE TABLE IF NOT EXISTS Historico (' +
    '  id INTEGER PRIMARY KEY AUTOINCREMENT,' +
    '  num_operacion TEXT NOT NULL,' +
    '  codigo_percha TEXT NOT NULL,' +
    '  codigo_random TEXT NOT NULL,' +
    '  fecha_hora_entrada TEXT NOT NULL,' +
    '  hash_sha256 TEXT NOT NULL,' +
    '  fecha_hora_retirada TEXT NOT NULL,' +
    '  importe_cobrado REAL DEFAULT 0.0,' +
    '  cobrado BOOLEAN DEFAULT 0,' +
    '  fecha_movimiento TEXT NOT NULL DEFAULT (datetime(''now''))' +
    ');'
  );

  // Índices para búsquedas rápidas
  FDConnection1.ExecSQL(
    'CREATE INDEX IF NOT EXISTS idx_hash_perchas ON Perchas(hash_sha256);'
  );
  FDConnection1.ExecSQL(
    'CREATE INDEX IF NOT EXISTS idx_hash_historico ON Historico(hash_sha256);'
  );
  FDConnection1.ExecSQL(
    'CREATE INDEX IF NOT EXISTS idx_numop_perchas ON Perchas(num_operacion);'
  );
  FDConnection1.ExecSQL(
    'CREATE INDEX IF NOT EXISTS idx_numop_historico ON Historico(num_operacion);'
  );

  StatusBar1.Panels[1].Text := 'Base de datos creada/actualizada correctamente.';

  ConectarDataBase;
end;

procedure TfrmMain.edOperacionKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, #13, #27]) then
    Key := #0;
  case key of
    #13 : btnBusquedaManual.Click;
  end;
end;

procedure TfrmMain.edRutaDBChange(Sender: TObject);
begin
  // Opcional: reconectar si cambia la ruta (o solo al guardar)
  // Por ahora, solo guardamos al salir o al crear
  ConfiguracionCambiada(Sender);
end;

procedure TfrmMain.edtqrKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then btnBuscarHashClick(Sender);
end;

procedure TfrmMain.ConfiguracionCambiada(Sender: TObject);
begin
  if not FCargandoConfiguracion then
    if HuboCambios then FConfiguracionModificada := True
    else FConfiguracionModificada := False;

  edImportePorDefecto.Enabled := chkCobrar.Checked;

end;

function TfrmMain.GenerarQRyGuardar(const ATexto: string): Boolean;
var
  QR: TDelphiZXingQRCode;
  Bitmap: TBitmap;
  JPEG: TJPEGImage;
  Row, Col, ModuleSize: Integer;
  QRSize, OutputSize: Integer;
  FileName: string;
begin
  Result := False;
  QR := nil;
  Bitmap := nil;
  JPEG := nil;
  try
    // Configurar tamaño del QR (mínimo 21x21 módulos)
    QRSize := 300;        // Tamaño final en píxeles
    OutputSize := QRSize;

    // Crear el QR
    QR := TDelphiZXingQRCode.Create;
    try
      QR.Data := ATexto;
      QR.Encoding := qrAuto;
      QR.QuietZone := 2; // Margen blanco alrededor (mínimo recomendado)

      // Crear bitmap
      Bitmap := TBitmap.Create;
      Bitmap.SetSize(OutputSize, OutputSize);
      Bitmap.Canvas.Brush.Color := clWhite;
      Bitmap.Canvas.FillRect(Rect(0, 0, OutputSize, OutputSize));

      // Calcular tamaño de cada módulo (celda negra/blanca)
      ModuleSize := OutputSize div QR.Rows;
      if ModuleSize < 1 then ModuleSize := 1;

      // Dibujar los módulos negros
      for Row := 0 to QR.Rows - 1 do
        for Col := 0 to QR.Columns - 1 do
          if QR.IsBlack[Row, Col] then
          begin
            Bitmap.Canvas.Brush.Color := clBlack;
            Bitmap.Canvas.FillRect(
              Rect(
                Col * ModuleSize,
                Row * ModuleSize,
                (Col + 1) * ModuleSize,
                (Row + 1) * ModuleSize
              )
            );
          end;
    finally
      QR.Free;
    end;

    // Convertir a JPEG y guardar
    JPEG := TJPEGImage.Create;
    try
      JPEG.Assign(Bitmap);
      JPEG.CompressionQuality := 95;

      FileName := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'QRPRENDA.JPG');
      JPEG.SaveToFile(FileName);
      Result := True;
    except
      on E: Exception do
      begin
        ShowMessage('Error al guardar QR: ' + E.Message);
        Result := False;
      end;
    end;
  finally
    Bitmap.Free;
    JPEG.Free;
  end;
end;


procedure TfrmMain.ImprimirTickets(const AHash, APercha, ANumOperacion: string; ACopias: Integer = 1);
var
  i: Integer;
  ComandoCorte: RawByteString;
begin
  if cbImpresoras.ItemIndex >= 0 then
    Printer.PrinterIndex := cbImpresoras.ItemIndex
  else
    Printer.PrinterIndex := -1;

  Printer.Title := 'Ticket Guardarropa';

  for i := 1 to ACopias do
  begin
    Printer.BeginDoc;
    try
      ImprimirContenidoTicket(AHash, APercha, ANumOperacion);
    finally
      Printer.EndDoc;
    end;

    // Corte DESPUÉS de cada página/copía
    if chkAutocorte.Checked then
    begin
      ComandoCorte := ObtenerComandoCorte;
      if ComandoCorte <> '' then
        EnviarComandoRawSeguro(ComandoCorte);
    end;

    // Pequeña pausa entre copias
    if i < ACopias then
      Sleep(500);
  end;
end;

procedure TfrmMain.EnviarComandoRawSeguro(const Comando: RawByteString);
var
  hPrinter: THandle;
  DocInfo: TDocInfo1;
  BytesEscritos: DWORD;
  ImpresoraNombre: string;
begin
  try
    if cbImpresoras.ItemIndex >= 0 then
      ImpresoraNombre := cbImpresoras.Text
    else
      ImpresoraNombre := Printer.Printers[Printer.PrinterIndex];

    // Abrir impresora usando Windows API (más seguro)
    if OpenPrinter(PChar(ImpresoraNombre), hPrinter, nil) then
    try
      FillChar(DocInfo, SizeOf(DocInfo), 0);
      DocInfo.pDocName := 'Comando de corte';
      DocInfo.pOutputFile := nil;
      DocInfo.pDatatype := 'RAW';

      if StartDocPrinter(hPrinter, 1, @DocInfo) > 0 then
      try
        if StartPagePrinter(hPrinter) then
        try
          WritePrinter(hPrinter, PAnsiChar(Comando), Length(Comando), BytesEscritos);
        finally
          EndPagePrinter(hPrinter);
        end;
      finally
        EndDocPrinter(hPrinter);
      end;
    finally
      ClosePrinter(hPrinter);
    end;
  except
    // Silenciar errores - la impresora puede no soportar comandos raw
  end;
end;


procedure TfrmMain.EnviarComandoRaw(const Comando: RawByteString);
var
  Prn: TextFile;
  ImpresoraNombre: string;
begin
  try
    if cbImpresoras.ItemIndex >= 0 then
      ImpresoraNombre := cbImpresoras.Text
    else
      ImpresoraNombre := Printer.Printers[Printer.PrinterIndex];

    // Abrir impresora directamente
    AssignPrn(Prn);
    Rewrite(Prn, ImpresoraNombre);
    Write(Prn, Comando);
    CloseFile(Prn);
  except
    on E: Exception do
    begin
      // Silenciar errores (impresora no soporta comandos raw)
      // o mostrar advertencia si lo deseas
    end;
  end;
end;


function TfrmMain.GenerarQRDesdeHash(const ATexto: string): TBitmap;
var
  QR: TDelphiZXingQRCode;
  Row, Col, ModuleSize: Integer;
begin
  Result := TBitmap.Create;
  try
    QR := TDelphiZXingQRCode.Create;
    try
      QR.Data := ATexto;
      QR.Encoding := qrAuto;
      QR.QuietZone := 2;

      Result.SetSize(150, 150);
      Result.Canvas.Brush.Color := clWhite;
      Result.Canvas.FillRect(Rect(0, 0, 150, 150));

      ModuleSize := 150 div QR.Rows;
      if ModuleSize < 1 then ModuleSize := 1;

      for Row := 0 to QR.Rows - 1 do
        for Col := 0 to QR.Columns - 1 do
          if QR.IsBlack[Row, Col] then
          begin
            Result.Canvas.Brush.Color := clBlack;
            Result.Canvas.FillRect(
              Rect(
                Col * ModuleSize,
                Row * ModuleSize,
                (Col + 1) * ModuleSize,
                (Row + 1) * ModuleSize
              )
            );
          end;
    finally
      QR.Free;
    end;
  except
    Result.Free;
    raise;
  end;
end;


procedure TfrmMain.ImprimirTicketUnico(const AHash, APercha, ANumOperacion: string);
var
  QRBitmap: TBitmap;
  NombreLocal: string;
  MostrarPercha: Boolean;
  YPos, AnchoPagina, MargenX, QRSize, AnchoDelTexto: Integer;
  FontSizeTitulo, FontSizeNormal, FontSizePequena: Integer;
begin
  // Configuración desde UI
  NombreLocal := Trim(edNombreLocal.Text);
  if NombreLocal = '' then
    NombreLocal := 'GUARDARROPA';
  MostrarPercha := chkMostrarPercha.Checked;

  // Generar QR
  QRBitmap := GenerarQRDesdeHash(AHash);
  try
    // === INICIAR EL DOCUMENTO DE IMPRESIÓN ===
    Printer.Title := 'Ticket Guardarropa';
    Printer.BeginDoc;
    try
      // Obtener dimensiones de la página (en píxeles) - ¡AHORA SÍ ESTÁ DISPONIBLE!
      AnchoPagina := Printer.PageWidth;
      MargenX := AnchoPagina div 10;
      if MargenX < 20 then MargenX := 20;

      // Tamaño del QR
      QRSize := (AnchoPagina - 2 * MargenX) * 60 div 100;
      if QRSize < 100 then QRSize := 100;

      with Printer.Canvas do
      begin
        YPos := 50;

        // === SECCIÓN 1: NOMBRE DEL LOCAL (centrado) ===
        Font.Size := 16;
        Font.Style := [fsBold];
        FontSizeTitulo := TextHeight('Ag');
        AnchoDelTexto := TextWidth(NombreLocal);
        TextOut((AnchoPagina - AnchoDelTexto) div 2, YPos, NombreLocal);
        YPos := YPos + FontSizeTitulo + 30;

        // === SECCIÓN 2: LÍNEA DESCRIPTIVA (centrado) ===
        Font.Size := 12;
        Font.Style := [];
        FontSizeNormal := TextHeight('Ag');
        AnchoDelTexto := TextWidth('TICKET GUARDARROPA');
        TextOut((AnchoPagina - AnchoDelTexto) div 2, YPos, 'TICKET GUARDARROPA');
        YPos := YPos + FontSizeNormal + 40;


        // === SECCIÓN 3: CÓDIGO QR ===
        if Assigned(QRBitmap) then
        begin
          StretchDraw(
            Rect(
              (AnchoPagina - QRSize) div 2,
              YPos,
              (AnchoPagina + QRSize) div 2,
              YPos + QRSize
            ),
            QRBitmap
          );
          YPos := YPos + QRSize + 40;
        end;

        // === SECCIÓN 4: DATOS DE OPERACIÓN (izquierda o centrado ya veré) ===
        if MostrarPercha then
        begin
          Font.Size := 14;
          Font.Style := [fsBold];
          FontSizeNormal := TextHeight('Ag');

          AnchoDelTexto := TextWidth('OPERACIÓN: ' + ANumOperacion);
          TextOut((AnchoPagina - AnchoDelTexto) div 2, YPos, 'OPERACIÓN: ' + ANumOperacion);
          YPos := YPos + FontSizeNormal + 10;

          AnchoDelTexto := TextWidth('PERCHA Nº: ' + APercha);
          TextOut((AnchoPagina - AnchoDelTexto) div 2, YPos, 'PERCHA Nº: ' + APercha);
          YPos := YPos + FontSizeNormal + 30;
        end;

        // === SECCIÓN 5: PIE DE PÁGINA (centrado) ===
        Font.Size := 9;
        Font.Style := [fsItalic];
        FontSizePequena := TextHeight('Ag');

        AnchoDelTexto := TextWidth('Gracias por su confianza.');
        TextOut((AnchoPagina - AnchoDelTexto) div 2, YPos, 'Gracias por su confianza.');
        YPos := YPos + FontSizePequena + 5;

        AnchoDelTexto := TextWidth('La empresa no se hace responsable de la pérdida de este ticket.');
        TextOut((AnchoPagina - AnchoDelTexto) div 2, YPos, 'La empresa no se hace responsable de la pérdida de este ticket.');
      end;
    finally
      Printer.EndDoc; //
    end;
  finally
    QRBitmap.Free;
  end;
end;


procedure TfrmMain.ImprimirContenidoTicket(const AHash, APercha, ANumOperacion: string);
var
  QRBitmap: TBitmap;
  NombreLocal: string;
  MostrarPercha: Boolean;
  YPos, AnchoPagina, MargenX, QRSize, AnchoDelTexto: Integer;
  FontSizeTitulo, FontSizeNormal, FontSizePequena: Integer;
begin
  // Configuración desde UI
  NombreLocal := Trim(edNombreLocal.Text);
  if NombreLocal = '' then
    NombreLocal := 'GUARDARROPA';
  MostrarPercha := chkMostrarPercha.Checked;

  // Obtener dimensiones de la página (en píxeles) - ¡YA ESTÁ DENTRO DE BeginDoc!
  AnchoPagina := Printer.PageWidth;
  MargenX := AnchoPagina div 10;
  if MargenX < 20 then MargenX := 20;

  // Tamaño del QR
  QRSize := (AnchoPagina - 2 * MargenX) * 60 div 100;
  if QRSize < 100 then QRSize := 100;

  // Generar QR
  QRBitmap := GenerarQRDesdeHash(AHash);
  try
    with Printer.Canvas do
    begin
      YPos := 50;

      // === SECCIÓN 1: NOMBRE DEL LOCAL (centrado) ===
      Font.Size := 16;
      Font.Style := [fsBold];
      FontSizeTitulo := TextHeight('Ag');
      AnchoDelTexto := TextWidth(NombreLocal);
      TextOut((AnchoPagina - AnchoDelTexto) div 2, YPos, NombreLocal);
      YPos := YPos + FontSizeTitulo + 30;

      // === SECCIÓN 2: LÍNEA DESCRIPTIVA (centrado) ===
      Font.Size := 12;
      Font.Style := [];
      FontSizeNormal := TextHeight('Ag');
      AnchoDelTexto := TextWidth('TICKET GUARDARROPA');
      TextOut((AnchoPagina - AnchoDelTexto) div 2, YPos, 'TICKET GUARDARROPA');
      YPos := YPos + FontSizeNormal + 40;

      // === SECCIÓN 3: CÓDIGO QR ===
      if Assigned(QRBitmap) then
      begin
        StretchDraw(
          Rect(
            (AnchoPagina - QRSize) div 2,
            YPos,
            (AnchoPagina + QRSize) div 2,
            YPos + QRSize
          ),
          QRBitmap
        );
        YPos := YPos + QRSize + 40;
      end;

      // === SECCIÓN 4: DATOS DE OPERACIÓN (izquierda) ===
      if MostrarPercha then
      begin
        Font.Size := 14;
        Font.Style := [fsBold];
        FontSizeNormal := TextHeight('Ag');

        AnchoDelTexto := TextWidth('OPERACIÓN: ' + ANumOperacion);
        TextOut((AnchoPagina - AnchoDelTexto) div 2, YPos, 'OPERACIÓN: ' + ANumOperacion);
        YPos := YPos + FontSizeNormal + 10;

        AnchoDelTexto := TextWidth('PERCHA Nº: ' + APercha);
        TextOut((AnchoPagina - AnchoDelTexto) div 2, YPos, 'PERCHA Nº: ' + APercha);
        YPos := YPos + FontSizeNormal + 30;
      end;

      // === SECCIÓN 5: PIE DE PÁGINA (centrado) ===
      Font.Size := 9;
      Font.Style := [fsItalic];
      FontSizePequena := TextHeight('Ag');

      AnchoDelTexto := TextWidth('Gracias por su confianza.');
      TextOut((AnchoPagina - AnchoDelTexto) div 2, YPos, 'Gracias por su confianza.');
      YPos := YPos + FontSizePequena + 5;

      Font.Size := 7;
      Font.Style := [fsItalic];
      FontSizePequena := TextHeight('Ag');

      AnchoDelTexto := TextWidth('La empresa no se hace responsable de la pérdida de este ticket.');
      TextOut((AnchoPagina - AnchoDelTexto) div 2, YPos, 'La empresa no se hace responsable de la pérdida de este ticket.');
    end;
  finally
    QRBitmap.Free;
  end;
end;

procedure TfrmMain.MoverAlHistorico(const AHash: string);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDConnection1;

    // Copiar registro de activas a histórico
    Query.SQL.Text :=
      'INSERT INTO Historico ' +
      '(num_operacion, codigo_percha, codigo_random, fecha_hora_entrada, ' +
      ' hash_sha256, fecha_hora_retirada, importe_cobrado, cobrado) ' +
      'SELECT num_operacion, codigo_percha, codigo_random, fecha_hora_entrada, ' +
      '       hash_sha256, :fecha_retirada, importe_cobrado, cobrado ' +
      'FROM Perchas WHERE hash_sha256 = :hash';
    Query.ParamByName('hash').AsString := AHash;
    Query.ParamByName('fecha_retirada').AsString := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
    Query.ExecSQL;

    // Eliminar de Perchas
    Query.SQL.Text := 'DELETE FROM Perchas WHERE hash_sha256 = :hash';
    Query.ParamByName('hash').AsString := AHash;
    Query.ExecSQL;

    // Aquí va un commit para guardar porque venimos de varias transacciones y seguro que algo queda por ahí

    FDConnection1.Commit;
    ActualizarContadorPerchas;

  finally
    Query.Free;
  end;
end;

function TfrmMain.ContarPerchasActivas: Integer;
var
  Query: TFDQuery;
  DBPath : String;
begin
  DBPath := GetDatabasePath;
  lblContadorPerchas.Visible := FileExists(GetDatabasePath);
  if FileExists(DBPath) then
  begin
    Result := 0;
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := FDConnection1;
      Query.SQL.Text := 'SELECT COUNT(*) FROM Perchas';
      Query.Open;
      if not Query.Eof then
        Result := Query.Fields[0].AsInteger;
    finally
      Query.Free;
    end;
  end;
end;

procedure TfrmMain.ActualizarContadorPerchas;
begin
  FContadorPerchas := ContarPerchasActivas;
  lblContadorPerchas.Caption := IntToStr(FContadorPerchas);
end;

function TFrmMain.ExisteDatabase:Boolean;
begin
  result := FileExists(GetDatabasePath);
  if not result then
  begin
      StatusBar1.Panels[0].Text := 'BASE DESCONECTADA';
      StatusBar1.Panels[1].Text := 'No existe el fichero de Base de Datos. Crear en la sección de CONFIGURACIÓN';
  end;
end;

procedure TFrmMain.EscribeLog(const NombreFichero, Msg: string);
var
  PathLog: string;
  FileStream: TStreamWriter;
begin
  // Obtiene la ruta del ejecutable y define el nombre del archivo
  PathLog := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), NombreFichero);

  // El parámetro True indica que añadirá texto al final (Append)
  FileStream := TStreamWriter.Create(PathLog, True, TEncoding.UTF8);
  try
    FileStream.WriteLine('['+FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + '] - ' + Msg);
  finally
    FileStream.Free;
  end;
end;

procedure TFrmMain.Informacion(const Msg: string);
begin
  if ExisteDatabase then
    lblInformacion.Caption := msg
  else lblInformacion.Caption := '';
end;

procedure TfrmMain.ConfigurarColumnasHistorico;
begin
  GridHistorico.Columns.Clear;

  with GridHistorico.Columns.Add do
  begin
    FieldName := 'num_operacion';
    Title.Caption := 'Operación';
    Width := 80;
  end;

  with GridHistorico.Columns.Add do
  begin
    FieldName := 'codigo_percha';
    Title.Caption := 'Percha';
    Width := 70;
  end;

  with GridHistorico.Columns.Add do
  begin
    FieldName := 'fecha_hora_entrada';
    Title.Caption := 'Entrada';
    Width := 140;
  end;

  with GridHistorico.Columns.Add do
  begin
    FieldName := 'fecha_hora_retirada';
    Title.Caption := 'Retirada';
    Width := 140;
  end;

  with GridHistorico.Columns.Add do
  begin
    FieldName := 'importe_cobrado';
    Title.Caption := 'Importe';
    Width := 80;
  end;

  with GridHistorico.Columns.Add do
  begin
    FieldName := 'cobrado';
    Title.Caption := 'Cobrado';
    Width := 70;
    // Convertir 1/0 a Sí/No
    PickList.Add('Sí');
    PickList.Add('No');
  end;

  with GridHistorico.Columns.Add do
  begin
    FieldName := 'fecha_movimiento';
    Title.Caption := 'Movimiento';
    Width := 140;
  end;
end;

procedure TfrmMain.MostrarTodosHistorico;
begin
  qryHistorico.Close;
  qryHistorico.SQL.Text :=
    'SELECT ' +
    '  CAST(num_operacion AS TEXT) AS num_operacion, ' +
    '  CAST(codigo_percha AS TEXT) AS codigo_percha, ' +
    '  CAST(fecha_hora_entrada AS TEXT) AS fecha_hora_entrada, ' +
    '  CAST(fecha_hora_retirada AS TEXT) AS fecha_hora_retirada, ' +
    '  CAST(importe_cobrado AS REAL) AS importe_cobrado, ' +
    '  CAST(cobrado AS INTEGER) AS cobrado, ' +
    '  CAST(fecha_movimiento AS TEXT) AS fecha_movimiento ' +
    'FROM Historico ' +
    'ORDER BY fecha_movimiento DESC';
  qryHistorico.Open;
end;

procedure TfrmMain.RecuperarDesdeDialogo(Sender: TObject);
var
  dlg: TdlgDetallesHistorico;
  PerchaLibre: Boolean;
begin
  dlg := Sender as TdlgDetallesHistorico;

  // Verificar percha libre
  PerchaLibre := EsPerchaLibre(dlg.CodigoPercha);
  if not PerchaLibre then
  begin
    if MessageDlg('La percha ' + dlg.CodigoPercha + ' ya está ocupada.' + #13#10 +
                  '¿Desea sobrescribir? (Esto eliminará la prenda actual)',
                  mtWarning, [mbYes, mbNo], 0) = mrNo then
    begin
      Exit;
    end;
    EliminarPrendaPorPercha(dlg.CodigoPercha);
  end;

  // Mover del histórico a Perchas
  if MoverDelHistoricoAPerchas(dlg.NumOperacion, dlg.CodigoPercha, dlg.Hash,
                               dlg.CodigoRandom, dlg.FechaEntrada,
                               dlg.ImporteCobrado, dlg.Cobrado) then
  begin
    ShowMessage('✅ Prenda recuperada exitosamente');
    ActualizarGridPrendas;
    ActualizarContadorPerchas;
    MostrarTodosHistorico;

    // Cerrar el diálogo
    TdlgDetallesHistorico(Sender).ModalResult := mrOk;
  end
  else
  begin
    ShowMessage('❌ Error al recuperar la prenda');
  end;
end;

function TfrmMain.ObtenerHashDelHistorico(const ANumOperacion: string): string;
var
  Query: TFDQuery;
begin
  Result := '';
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDConnection1;
    Query.SQL.Text :=
      'SELECT hash_sha256 FROM Historico WHERE num_operacion = :num';
    Query.ParamByName('num').AsString := ANumOperacion;
    Query.Open;
    if not Query.Eof then
      Result := Query.FieldByName('hash_sha256').AsString;
  finally
    Query.Free;
  end;
end;

function TfrmMain.ObtenerCodigoRandomDelHistorico(const ANumOperacion: string): string;
var
  Query: TFDQuery;
begin
  Result := '';
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDConnection1;
    Query.SQL.Text :=
      'SELECT codigo_random FROM Historico WHERE num_operacion = :num';
    Query.ParamByName('num').AsString := ANumOperacion;
    Query.Open;
    if not Query.Eof then
      Result := Query.FieldByName('codigo_random').AsString;
  finally
    Query.Free;
  end;
end;

function TfrmMain.EsPerchaLibre(const ACodigoPercha: string): Boolean;
var
  Query: TFDQuery;
begin
  Result := True;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDConnection1;
    Query.SQL.Text :=
      'SELECT COUNT(*) FROM Perchas WHERE codigo_percha = :percha';
    Query.ParamByName('percha').AsString := ACodigoPercha;
    Query.Open;
    Result := (Query.Fields[0].AsInteger = 0);
  finally
    Query.Free;
  end;
end;

procedure TfrmMain.EliminarPrendaPorPercha(const ACodigoPercha: string);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDConnection1;
    // Primero mover al histórico
    Query.SQL.Text :=
      'INSERT INTO Historico ' +
      '(num_operacion, codigo_percha, codigo_random, fecha_hora_entrada, ' +
      ' hash_sha256, fecha_hora_retirada, importe_cobrado, cobrado) ' +
      'SELECT num_operacion, codigo_percha, codigo_random, fecha_hora_entrada, ' +
      '       hash_sha256, :fecha_retirada, importe_cobrado, cobrado ' +
      'FROM Perchas WHERE codigo_percha = :percha';
    Query.ParamByName('percha').AsString := ACodigoPercha;
    Query.ParamByName('fecha_retirada').AsString := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
    Query.ExecSQL;

    // Luego eliminar
    Query.SQL.Text := 'DELETE FROM Perchas WHERE codigo_percha = :percha';
    Query.ParamByName('percha').AsString := ACodigoPercha;
    Query.ExecSQL;

    FDConnection1.Commit;
  finally
    Query.Free;
  end;
end;

function TfrmMain.MoverDelHistoricoAPerchas(const ANumOperacion, ACodigoPercha, AHash,
  ACodigoRandom, AFechaEntrada, AImporteCobrado: string; ACobrado: Integer): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDConnection1;

    // Insertar en Perchas
    Query.SQL.Text :=
      'INSERT INTO Perchas ' +
      '(num_operacion, codigo_percha, codigo_random, fecha_hora_entrada, ' +
      ' hash_sha256, importe_cobrado, cobrado) ' +
      'VALUES (:num, :percha, :rand, :fecha, :hash, :importe, :cobrado)';
    Query.ParamByName('num').AsString := ANumOperacion;
    Query.ParamByName('percha').AsString := ACodigoPercha;
    Query.ParamByName('rand').AsString := ACodigoRandom;
    Query.ParamByName('fecha').AsString := AFechaEntrada;
    Query.ParamByName('hash').AsString := AHash;
    Query.ParamByName('importe').AsString := AImporteCobrado;
    Query.ParamByName('cobrado').AsInteger := ACobrado;
    Query.ExecSQL;

    // Eliminar del histórico
    Query.SQL.Text := 'DELETE FROM Historico WHERE num_operacion = :num';
    Query.ParamByName('num').AsString := ANumOperacion;
    Query.ExecSQL;

    FDConnection1.Commit;
    Result := True;

  except
    on E: Exception do
    begin
      ShowMessage('Error al mover del histórico: ' + E.Message);
      Result := False;
    end;
  end;
  Query.Free;
end;

function TfrmMain.GetAppDataPath: string;
begin
  Result := TPath.Combine(GetEnvironmentVariable('APPDATA'), 'GuardaRRopa');
  TDirectory.CreateDirectory(Result);
end;

function TfrmMain.GetConfigFilePath: string;
begin
  Result := TPath.Combine(GetAppDataPath, 'config.ini');
end;

function TfrmMain.ObtenerComandoCorte: RawByteString;
begin
  Result := '';

  if not chkAutocorte.Checked then
    Exit;

  case cbTipoCorte.ItemIndex of
    0: Result := #$1B + 'm';         // EPSON corte parcial
    1: Result := #$1B + 'i';         // EPSON corte completo
    2: Result := #$1D + 'V' + #$31;  // STAR corte parcial
    3: Result := #$1D + 'V' + #$41;  // STAR corte completo
    4: Result := HexStringToRawByteString(Trim(edComandoPersonalizado.Text));
  end;
end;

function TfrmMain.HexStringToRawByteString(const Hex: string): RawByteString;
var
  i: Integer;
begin
  Result := '';
  i := 1;
  while i <= Length(Hex) do
  begin
    if Hex[i] = ' ' then
      Inc(i)
    else
    begin
      Result := Result + AnsiChar(StrToInt('$' + Copy(Hex, i, 2)));
      Inc(i, 2);
    end;
  end;
end;


function TfrmMain.HexToBin(const HexStr: string): RawByteString;
var
  i: Integer;
  ByteStr: string;
begin
  Result := '';
  for i := 1 to Length(HexStr) div 2 do
  begin
    ByteStr := Copy(HexStr, (i-1)*2 + 1, 2);
    Result := Result + Char(StrToInt('$' + ByteStr));
  end;
end;


end.
