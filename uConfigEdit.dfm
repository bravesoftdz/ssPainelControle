object frmConfigEdit: TfrmConfigEdit
  Left = 192
  Top = 124
  Width = 523
  Height = 468
  BorderIcons = [biSystemMenu]
  Caption = 'frmConfigEdit'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object s: TRzPageControl
    Left = 0
    Top = 0
    Width = 515
    Height = 400
    ActivePage = TabSheet5
    ActivePageDefault = TabSheet1
    Align = alClient
    TabIndex = 1
    TabOrder = 0
    FixedDimension = 19
    object TabSheet1: TRzTabSheet
      Caption = 'Banco de dados'
      object GroupBox1: TGroupBox
        Left = 8
        Top = 145
        Width = 459
        Height = 96
        Caption = 'Banco de Dados de Log '
        TabOrder = 1
        object Label1: TLabel
          Left = 41
          Top = 24
          Width = 63
          Height = 13
          Alignment = taRightJustify
          Caption = 'Arquivo FDB:'
        end
        object Label2: TLabel
          Left = 65
          Top = 48
          Width = 39
          Height = 13
          Alignment = taRightJustify
          Caption = 'Usu'#225'rio:'
        end
        object Label3: TLabel
          Left = 70
          Top = 72
          Width = 34
          Height = 13
          Alignment = taRightJustify
          Caption = 'Senha:'
        end
        object Edit4: TEdit
          Left = 112
          Top = 64
          Width = 145
          Height = 21
          PasswordChar = '*'
          TabOrder = 2
          Text = 'masterkey'
        end
        object Edit5: TEdit
          Left = 112
          Top = 40
          Width = 145
          Height = 21
          TabOrder = 1
          Text = 'SYSDBA'
        end
        object Edit6: TEdit
          Left = 112
          Top = 16
          Width = 329
          Height = 21
          TabOrder = 0
          Text = 'localhost:c:\$Servisoft\Dados\SSFacil\Log.fdb'
        end
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 16
        Width = 459
        Height = 121
        Caption = 'Banco de Dados Principal '
        TabOrder = 0
        object Label4: TLabel
          Left = 41
          Top = 24
          Width = 63
          Height = 13
          Alignment = taRightJustify
          Caption = 'Arquivo FDB:'
        end
        object Label5: TLabel
          Left = 65
          Top = 72
          Width = 39
          Height = 13
          Alignment = taRightJustify
          Caption = 'Usu'#225'rio:'
        end
        object Label6: TLabel
          Left = 70
          Top = 96
          Width = 34
          Height = 13
          Alignment = taRightJustify
          Caption = 'Senha:'
        end
        object Label23: TLabel
          Left = 113
          Top = 40
          Width = 293
          Height = 13
          Caption = 'Ex.: 192.168.1.1:c:\$Servisoft\SSFacil\SSFacil.fdb'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Edit1: TEdit
          Left = 112
          Top = 16
          Width = 329
          Height = 21
          TabOrder = 0
          Text = 'localhost:c:\$Servisoft\Dados\SSFacil\SSFacil.fdb'
        end
        object Edit2: TEdit
          Left = 112
          Top = 64
          Width = 145
          Height = 21
          TabOrder = 1
          Text = 'SYSDBA'
        end
        object Edit3: TEdit
          Left = 112
          Top = 88
          Width = 145
          Height = 21
          PasswordChar = '*'
          TabOrder = 2
          Text = 'masterkey'
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 249
        Width = 459
        Height = 120
        Caption = 'Banco de Dados de Atualiza'#231#227'o '
        TabOrder = 2
        object Label15: TLabel
          Left = 41
          Top = 24
          Width = 63
          Height = 13
          Alignment = taRightJustify
          Caption = 'Arquivo FDB:'
        end
        object Label16: TLabel
          Left = 65
          Top = 72
          Width = 39
          Height = 13
          Alignment = taRightJustify
          Caption = 'Usu'#225'rio:'
        end
        object Label17: TLabel
          Left = 70
          Top = 96
          Width = 34
          Height = 13
          Alignment = taRightJustify
          Caption = 'Senha:'
        end
        object Label25: TLabel
          Left = 113
          Top = 40
          Width = 316
          Height = 13
          Caption = 'Ex.: 192.168.1.1:c:\$Servisoft\SSFacil\AtualizaFdb.fdb'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Edit15: TEdit
          Left = 112
          Top = 88
          Width = 145
          Height = 21
          PasswordChar = '*'
          TabOrder = 2
          Text = 'masterkey'
        end
        object Edit16: TEdit
          Left = 112
          Top = 64
          Width = 145
          Height = 21
          TabOrder = 1
          Text = 'SYSDBA'
        end
        object Edit17: TEdit
          Left = 112
          Top = 16
          Width = 329
          Height = 21
          TabOrder = 0
          Text = 'localhost:c:\$Servisoft\Dados\SSFacil\Log.fdb'
        end
      end
    end
    object TabSheet5: TRzTabSheet
      Caption = 'NFe Config'
      object GroupBox5: TGroupBox
        Left = 8
        Top = 16
        Width = 459
        Height = 121
        Caption = 'Banco de Dados'
        TabOrder = 0
        object Label26: TLabel
          Left = 41
          Top = 24
          Width = 63
          Height = 13
          Alignment = taRightJustify
          Caption = 'Arquivo FDB:'
        end
        object Label27: TLabel
          Left = 65
          Top = 72
          Width = 39
          Height = 13
          Alignment = taRightJustify
          Caption = 'Usu'#225'rio:'
        end
        object Label28: TLabel
          Left = 70
          Top = 96
          Width = 34
          Height = 13
          Alignment = taRightJustify
          Caption = 'Senha:'
        end
        object Label22: TLabel
          Left = 113
          Top = 40
          Width = 307
          Height = 13
          Caption = 'Ex.: 192.168.1.1:C:\$Servisoft\NFeConfig\NFeDB.fdb'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Edit22: TEdit
          Left = 112
          Top = 16
          Width = 329
          Height = 21
          TabOrder = 0
          Text = 'NFeDB.fdb'
        end
        object Edit23: TEdit
          Left = 112
          Top = 64
          Width = 145
          Height = 21
          TabOrder = 1
          Text = 'SYSDBA'
        end
        object Edit24: TEdit
          Left = 112
          Top = 88
          Width = 145
          Height = 21
          PasswordChar = '*'
          TabOrder = 2
          Text = 'masterkey'
        end
      end
    end
    object TabSheet2: TRzTabSheet
      Caption = 'Atualiza'#231#227'o FTP'
      object Label7: TLabel
        Left = 37
        Top = 24
        Width = 72
        Height = 13
        Alignment = taRightJustify
        Caption = 'Endere'#231'o FTP:'
      end
      object Label8: TLabel
        Left = 70
        Top = 48
        Width = 39
        Height = 13
        Alignment = taRightJustify
        Caption = 'Usu'#225'rio:'
      end
      object Label9: TLabel
        Left = 75
        Top = 72
        Width = 34
        Height = 13
        Alignment = taRightJustify
        Caption = 'Senha:'
      end
      object Label10: TLabel
        Left = 59
        Top = 120
        Width = 50
        Height = 13
        Alignment = taRightJustify
        Caption = 'Salvar em:'
      end
      object Label11: TLabel
        Left = 24
        Top = 144
        Width = 85
        Height = 13
        Alignment = taRightJustify
        Caption = 'Pasta do servidor:'
      end
      object Label12: TLabel
        Left = 36
        Top = 192
        Width = 73
        Height = 13
        Alignment = taRightJustify
        Caption = 'Arquivo zipado:'
      end
      object Label13: TLabel
        Left = 46
        Top = 216
        Width = 63
        Height = 13
        Alignment = taRightJustify
        Caption = 'Arquivo FDB:'
      end
      object Label24: TLabel
        Left = 45
        Top = 168
        Width = 64
        Height = 13
        Alignment = taRightJustify
        Caption = 'Arquivo local:'
      end
      object Label29: TLabel
        Left = 264
        Top = 168
        Width = 68
        Height = 13
        Caption = 'SSFacil.exe'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label30: TLabel
        Left = 264
        Top = 192
        Width = 64
        Height = 13
        Caption = 'SSFacil.zip'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Edit7: TEdit
        Left = 112
        Top = 16
        Width = 329
        Height = 21
        TabOrder = 0
        Text = 'servisoft.no-ip.org'
      end
      object Edit8: TEdit
        Left = 112
        Top = 40
        Width = 145
        Height = 21
        TabOrder = 1
        Text = 'cliente'
      end
      object Edit9: TEdit
        Left = 112
        Top = 112
        Width = 329
        Height = 21
        TabOrder = 4
        Text = 'C:\$Servisoft\SSFacil\'
      end
      object Edit10: TEdit
        Left = 112
        Top = 64
        Width = 145
        Height = 21
        PasswordChar = '*'
        TabOrder = 2
        Text = '297sl2'
      end
      object Edit11: TEdit
        Left = 112
        Top = 136
        Width = 329
        Height = 21
        TabOrder = 5
        Text = 'SSFacil'
      end
      object Edit12: TEdit
        Left = 112
        Top = 208
        Width = 145
        Height = 21
        TabOrder = 8
        Text = 'ATUALIZA.FDB'
      end
      object Edit13: TEdit
        Left = 112
        Top = 184
        Width = 145
        Height = 21
        TabOrder = 7
        Text = 'SSFacil.zip'
      end
      object CheckBox1: TCheckBox
        Left = 112
        Top = 88
        Width = 97
        Height = 17
        Caption = 'Passivo'
        TabOrder = 3
      end
      object Edit25: TEdit
        Left = 112
        Top = 160
        Width = 145
        Height = 21
        TabOrder = 6
        Text = 'SSFacil.exe'
      end
      object Panel2: TPanel
        Left = 0
        Top = 263
        Width = 511
        Height = 114
        Align = alBottom
        TabOrder = 9
        object Label31: TLabel
          Left = 74
          Top = 45
          Width = 35
          Height = 13
          Alignment = taRightJustify
          Caption = 'Prefixo:'
        end
        object Label32: TLabel
          Left = 59
          Top = 69
          Width = 50
          Height = 13
          Alignment = taRightJustify
          Caption = 'Salvar em:'
        end
        object Label33: TLabel
          Left = 1
          Top = 1
          Width = 509
          Height = 22
          Align = alTop
          Alignment = taCenter
          Caption = 'RELAT'#211'RIOS'
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object Label34: TLabel
          Left = 112
          Top = 85
          Width = 187
          Height = 13
          Caption = 'Ex.: .\Relatorios ou ..\Relatorios'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Edit26: TEdit
          Left = 112
          Top = 37
          Width = 329
          Height = 21
          TabOrder = 0
          Text = 'NomeDoCliente'
        end
        object Edit27: TEdit
          Left = 112
          Top = 61
          Width = 329
          Height = 21
          TabOrder = 1
          Text = '.\Relatorios'
        end
      end
    end
    object TabSheet3: TRzTabSheet
      Caption = 'Atualiza'#231#227'o LAN'
      object Label14: TLabel
        Left = 30
        Top = 24
        Width = 73
        Height = 13
        Alignment = taRightJustify
        Caption = 'Endere'#231'o LAN:'
      end
      object Edit14: TEdit
        Left = 112
        Top = 16
        Width = 329
        Height = 21
        TabOrder = 0
        Text = 'servisoft.no-ip.org'
      end
    end
    object TabSheet4: TRzTabSheet
      Caption = 'Back Up'
      object Label18: TLabel
        Left = 40
        Top = 24
        Width = 63
        Height = 13
        Alignment = taRightJustify
        Caption = 'Arquivo BKP:'
      end
      object Label19: TLabel
        Left = 31
        Top = 48
        Width = 72
        Height = 13
        Alignment = taRightJustify
        Caption = 'Endere'#231'o FTP:'
      end
      object Label20: TLabel
        Left = 41
        Top = 96
        Width = 62
        Height = 13
        Alignment = taRightJustify
        Caption = 'Usu'#225'rio FTP:'
      end
      object Label21: TLabel
        Left = 46
        Top = 120
        Width = 57
        Height = 13
        Alignment = taRightJustify
        Caption = 'Senha FTP:'
      end
      object Label35: TLabel
        Left = 12
        Top = 184
        Width = 91
        Height = 13
        Alignment = taRightJustify
        Caption = 'Hor'#225'rio BKP Di'#225'rio:'
      end
      object Edit18: TEdit
        Left = 112
        Top = 16
        Width = 329
        Height = 21
        TabOrder = 0
      end
      object Edit19: TEdit
        Left = 112
        Top = 40
        Width = 329
        Height = 21
        TabOrder = 1
      end
      object Edit20: TEdit
        Left = 112
        Top = 88
        Width = 329
        Height = 21
        TabOrder = 2
      end
      object Edit21: TEdit
        Left = 112
        Top = 112
        Width = 329
        Height = 21
        PasswordChar = '*'
        TabOrder = 3
        Text = 'servisoft.no-ip.org'
      end
      object RzDateTimeEdit1: TRzDateTimeEdit
        Left = 112
        Top = 176
        Width = 65
        Height = 21
        EditType = etTime
        TabOrder = 4
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 400
    Width = 515
    Height = 37
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 162
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Gravar'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 242
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Ca&ncelar'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object Decoder64: TIdDecoderMIME
    FillChar = '='
    Left = 320
    Top = 360
  end
  object Encoder64: TIdEncoderMIME
    FillChar = '='
    Left = 352
    Top = 360
  end
end
