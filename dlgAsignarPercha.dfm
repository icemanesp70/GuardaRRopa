object frmAsignarPercha: TfrmAsignarPercha
  Left = 0
  Top = 0
  Caption = 'Asignaci'#243'n de PERCHA'
  ClientHeight = 90
  ClientWidth = 237
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 215
    Height = 21
    Caption = 'Introduzca n'#186' PERCHA (XXX)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object edPercha: TEdit
    Left = 16
    Top = 35
    Width = 210
    Height = 23
    MaxLength = 3
    TabOrder = 0
    OnKeyPress = edPerchaKeyPress
  end
  object btnAceptar: TButton
    Left = 20
    Top = 60
    Width = 100
    Height = 25
    Caption = 'Aceptar'
    TabOrder = 1
    OnClick = btnAceptarClick
  end
  object btnCancelar: TButton
    Left = 126
    Top = 60
    Width = 100
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 2
    OnClick = btnCancelarClick
  end
end
