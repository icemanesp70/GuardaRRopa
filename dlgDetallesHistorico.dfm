object dlgDetallesHistorico: TdlgDetallesHistorico
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Detalles de la percha'
  ClientHeight = 340
  ClientWidth = 450
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 433
    Height = 290
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 56
      Height = 13
      Caption = 'Operaci'#243'n :'
    end
    object lblOperacion: TLabel
      Left = 120
      Top = 16
      Width = 70
      Height = 13
      Caption = 'lblOperacion'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 40
      Width = 37
      Height = 13
      Caption = 'Percha:'
    end
    object lblPercha: TLabel
      Left = 120
      Top = 40
      Width = 52
      Height = 13
      Caption = 'lblPercha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 64
      Width = 42
      Height = 13
      Caption = 'Entrada:'
    end
    object lblEntrada: TLabel
      Left = 120
      Top = 64
      Width = 48
      Height = 13
      Caption = 'lblEntrada'
    end
    object Label4: TLabel
      Left = 16
      Top = 88
      Width = 45
      Height = 13
      Caption = 'Retirada:'
    end
    object lblRetirada: TLabel
      Left = 120
      Top = 88
      Width = 51
      Height = 13
      Caption = 'lblRetirada'
    end
    object Label5: TLabel
      Left = 16
      Top = 112
      Width = 42
      Height = 13
      Caption = 'Importe:'
    end
    object lblImporte: TLabel
      Left = 120
      Top = 112
      Width = 48
      Height = 13
      Caption = 'lblImporte'
    end
    object Label6: TLabel
      Left = 16
      Top = 136
      Width = 45
      Height = 13
      Caption = 'Cobrado:'
    end
    object lblCobrado: TLabel
      Left = 120
      Top = 136
      Width = 51
      Height = 13
      Caption = 'lblCobrado'
    end
    object Label7: TLabel
      Left = 16
      Top = 160
      Width = 28
      Height = 13
      Caption = 'Hash:'
    end
    object lblHash: TLabel
      Left = 16
      Top = 180
      Width = 34
      Height = 13
      Caption = 'lblHash'
      WordWrap = True
    end
    object Label8: TLabel
      Left = 16
      Top = 200
      Width = 58
      Height = 13
      Caption = 'Movimiento:'
    end
    object lblMovimiento: TLabel
      Left = 120
      Top = 200
      Width = 64
      Height = 13
      Caption = 'lblMovimiento'
    end
  end
  object btnRecuperar: TButton
    Left = 8
    Top = 304
    Width = 100
    Height = 25
    Caption = 'Recuperar prenda'
    TabOrder = 1
    OnClick = btnRecuperarClick
  end
  object btnCancel: TButton
    Left = 366
    Top = 304
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 2
  end
end
