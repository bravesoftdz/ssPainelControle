object frmUpdate: TfrmUpdate
  Left = 320
  Top = 108
  Width = 813
  Height = 545
  Caption = 'Atualiza'#231#227'o do Sistema e da Base de Dados'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 805
    Height = 62
    Align = alTop
    Color = 16753994
    TabOrder = 1
    object Label2: TLabel
      Left = 103
      Top = 15
      Width = 447
      Height = 36
      Alignment = taCenter
      Caption = 
        'O programa ir'#225' atualizar os softwares selecionados abaixo. '#13#10'A v' +
        'ers'#227'o anterior ser'#225' salva com a extens'#227'o DataDoDia.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 803
      Height = 13
      Align = alTop
      Alignment = taRightJustify
      Caption = 'Vers'#227'o 16/09/2020'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 451
    Width = 805
    Height = 63
    Align = alBottom
    Color = 16753994
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 0
    object StatusBar1: TStatusBar
      Left = 1
      Top = 43
      Width = 803
      Height = 19
      Panels = <
        item
          Width = 100
        end
        item
          Width = 175
        end
        item
          Width = 50
        end>
    end
    object btnAtualizar: TNxButton
      Left = 217
      Top = 8
      Width = 126
      Height = 27
      Cursor = crHandPoint
      Caption = 'Atualizar Sistemas'
      Down = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnAtualizarClick
    end
    object btnCancelar: TNxButton
      Left = 341
      Top = 8
      Width = 126
      Height = 27
      Cursor = crHandPoint
      Caption = 'Cancelar'
      Down = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object btnBanco: TNxButton
      Left = 465
      Top = 8
      Width = 126
      Height = 27
      Cursor = crHandPoint
      Caption = 'Atualizar Banco'
      Down = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnBancoClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 62
    Width = 805
    Height = 235
    Align = alClient
    TabOrder = 2
    object CheckListBox1: TCheckListBox
      Left = 1
      Top = 1
      Width = 803
      Height = 233
      Align = alClient
      BevelKind = bkSoft
      BorderStyle = bsNone
      Columns = 2
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ItemHeight = 18
      Items.Strings = (
        'SSF'#225'cil '
        'SSPar'#226'metros '
        'SSCupomFiscal'
        'SSF'#225'cil_OS  '
        'SSF'#225'cil_Prod '
        'SSF'#225'cil_MDFE '
        'SSUtilit'#225'rios  '
        'BackUp  '
        'BuscaIBPT '
        'SSNFCe  '
        'ConsultaCNPJ '
        'DLL Consulta CNPJ '
        'SSIntegradorPDV  '
        'SSIntegra'#231#227'o Cont'#225'bil'
        'Impress'#227'o Cozinha/Copa '
        'DLL Manifesto '
        'xtr SSFacil '
        'xtr NFeConfig '
        'NFeConfig '
        'AppPedido'
        'Servi'#231'o F'#225'cil (ACBr)'
        'Gaveta (SSNFCe)')
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 297
    Width = 805
    Height = 154
    Align = alBottom
    Color = clBtnShadow
    TabOrder = 3
    object Gauge1: TGauge
      Left = 18
      Top = 5
      Width = 658
      Height = 19
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Progress = 0
    end
    object Shape1: TShape
      Left = 26
      Top = 30
      Width = 13
      Height = 13
      Brush.Color = 8404992
    end
    object Label3: TLabel
      Left = 44
      Top = 28
      Width = 71
      Height = 16
      Caption = 'Programa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblVersaoNFEBD: TLabel
      Left = 1
      Top = 133
      Width = 803
      Height = 20
      Align = alBottom
      Alignment = taCenter
      Caption = 'Vers'#227'o do NFeBD: 00000 / Vers'#227'o do NFeBD de atualiza'#231#227'o: 00000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Segoe UI Light'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object gbxVendedor: TRzGroupBox
      Left = 239
      Top = 64
      Width = 333
      Height = 58
      BorderColor = clNavy
      BorderInner = fsButtonUp
      BorderOuter = fsBump
      Caption = ' Vers'#227'o do Banco '
      Color = clBtnShadow
      Ctl3D = True
      FlatColor = clNavy
      FlatColorAdjustment = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      VisualStyle = vsGradient
      object Label4: TLabel
        Left = 112
        Top = 17
        Width = 147
        Height = 16
        Caption = 'Vers'#227'o Banco Local:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblVersaoAtualizacao: TLabel
        Left = 271
        Top = 34
        Width = 45
        Height = 16
        Alignment = taRightJustify
        Caption = '00000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 21
        Top = 34
        Width = 238
        Height = 16
        Caption = 'Vers'#227'o da Banco de Atualiza'#231#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object ceVersaoLocal: TCurrencyEdit
      Left = 502
      Top = 77
      Width = 54
      Height = 21
      AutoSize = False
      Color = clBtnShadow
      Ctl3D = False
      DecimalPlaces = 0
      DisplayFormat = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object btnScriptAvulso: TNxButton
      Left = 442
      Top = 35
      Width = 133
      Caption = 'Rodar Script Avulso'
      TabOrder = 2
      Visible = False
      OnClick = btnScriptAvulsoClick
    end
  end
  object ftpUpdate: TIdFTP
    OnStatus = ftpUpdateStatus
    MaxLineAction = maException
    ReadTimeout = 0
    OnDisconnected = ftpUpdateDisconnected
    OnWork = ftpUpdateWork
    OnWorkBegin = ftpUpdateWorkBegin
    Host = 'ftp.ssfacil.inf.br'
    Passive = True
    Password = 'cliente'
    Username = 'ssfacil01'
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 312
    Top = 4
  end
  object Decoder64: TIdDecoderMIME
    FillChar = '='
    Left = 344
    Top = 4
  end
  object ZipMaster1: TZipMaster
    AddOptions = []
    AddStoreSuffixes = [assGIF, assPNG, assZ, assZIP, assZOO, assARC, assLZH, assARJ, assTAZ, assTGZ, assLHA, assRAR, assACE, assCAB, assGZ, assGZIP, assJAR, assJPG, assJPEG, ass7Zp, assMP3, assWMV, assWMA, assDVR, assAVI]
    ConfirmErase = False
    DLL_Load = False
    ExtrOptions = []
    KeepFreeOnAllDisks = 0
    KeepFreeOnDisk1 = 0
    LanguageID = 0
    MaxVolumeSizeKb = 0
    NoReadAux = False
    SFXOptions = []
    SFXOverwriteMode = ovrAlways
    SpanOptions = []
    Trace = False
    Unattended = False
    UseUTF8 = False
    Verbose = False
    Version = '1.9.1.0012'
    WriteOptions = []
    Left = 281
    Top = 4
  end
end
