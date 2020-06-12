unit uConfigEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, RzTabs,
  IniFiles, IdBaseComponent, IdCoder, IdCoder3to4, IdCoderMIME, Mask, ToolEdit,
  RzEdit, RzDBEdit;

type
  TfrmConfigEdit = class(TForm)
    s: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Decoder64: TIdDecoderMIME;
    CheckBox1: TCheckBox;
    Encoder64: TIdEncoderMIME;
    GroupBox3: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    TabSheet4: TRzTabSheet;
    Label18: TLabel;
    Edit18: TEdit;
    Label19: TLabel;
    Edit19: TEdit;
    Label20: TLabel;
    Edit20: TEdit;
    Label21: TLabel;
    Edit21: TEdit;
    Label23: TLabel;
    Label25: TLabel;
    TabSheet5: TRzTabSheet;
    GroupBox5: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Label22: TLabel;
    Label24: TLabel;
    Edit25: TEdit;
    Label29: TLabel;
    Label30: TLabel;
    Panel2: TPanel;
    Label31: TLabel;
    Edit26: TEdit;
    Label32: TLabel;
    Edit27: TEdit;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    RzDateTimeEdit1: TRzDateTimeEdit;
    Label36: TLabel;
    EdtLocalExeNFeconfig: TEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function lerIni(Tabela, Campo: String): String;
    procedure gravarIni(Tabela, Campo, Valor: String);
  public
    { Public declarations }
  end;

var
  frmConfigEdit: TfrmConfigEdit;

implementation

{$R *.dfm}

procedure TfrmConfigEdit.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

function TfrmConfigEdit.lerIni(Tabela, Campo: String): String;
var
  ServerIni: TIniFile;
begin
  ServerIni := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  result    := ServerIni.ReadString(Tabela,Campo,'');
  ServerIni.Free;
end;

procedure TfrmConfigEdit.FormShow(Sender: TObject);
begin
  //Carrega parâmetros banco de dados
  Edit1.Text := lerIni('SSFacil','database');
  Edit2.Text := lerIni('SSFacil','username');
  Edit3.Text := Decoder64.DecodeString(lerIni('SSFacil','password'));

  //Carrega parâmetros NFeConfig
  if lerIni('NFeConfig','database') <> '' then
    Edit22.Text := lerIni('NFeConfig','database');
  Edit23.Text := lerIni('NFeConfig','username');
  Edit24.Text := Decoder64.DecodeString(lerIni('NFeConfig','password'));
  EdtLocalExeNFeconfig.Text := lerIni('NFeConfig','LocalExe');

  //Carrega parâmetros log
  Edit6.Text := lerIni('bando de dados','database');
  Edit5.Text := lerIni('bando de dados','username');
  Edit4.Text := Decoder64.DecodeString(lerIni('bando de dados','password'));

  //Carrega parâmetros log
  Edit17.Text := lerIni('FDBUpdate','database');
  Edit16.Text := lerIni('FDBUpdate','username');
  Edit15.Text := Decoder64.DecodeString(lerIni('FDBUpdate','password'));

  //Carrega parâmetros ftp
  Edit7.Text  := lerIni('FTPUpdate','FTP');
  Edit8.Text  := lerIni('FTPUpdate','Username');
  Edit10.Text := Decoder64.DecodeString(lerIni('FTPUpdate','Password'));
  Edit9.Text  := lerIni('FTPUpdate','PastaCliente');
  Edit11.Text := lerIni('FTPUpdate','PastaServidorFTP');
  Edit25.Text := lerIni('FTPUpdate','ArquivoExe');
  Edit13.Text := lerIni('FTPUpdate','ArquivoZip');
  Edit12.Text := lerIni('FTPUpdate','DB');
  if lerIni('FTPUpdate','RelPrefixo') <> '' then
    Edit26.Text := lerIni('FTPUpdate','RelPrefixo');
  if lerIni('FTPUpdate','RelPasta') <> '' then
    Edit27.Text := lerIni('FTPUpdate','RelPasta');
  if lerIni('FTPUpdate','Passivo') = 'S' then
    CheckBox1.Checked := True
  else
    CheckBox1.Checked := False;

  //Carrega parâmetros lan
  Edit14.Text := lerIni('LANUpdate','LOCAL');

  //Carrega parâmtros BKP
  Edit18.Text := lerIni('BackUp','Arquivo');
  Edit19.Text := lerIni('BackUp','FTP');
  Edit20.Text := lerIni('BackUp','Username');
  Edit21.Text := Decoder64.DecodeString(lerIni('BackUp','Password'));
  RzDateTimeEdit1.Text := lerIni('BackUp','Hora');
  if trim(Edit12.Text) = '' then
    Edit12.Text := 'AtualizaFDB.fdb';
  if trim(Edit25.Text) = '' then
    Edit25.Text := 'SSFacil.exe';
  if trim(Edit13.Text) = '' then
    Edit13.Text := 'SSFacil.zip';
end;

procedure TfrmConfigEdit.BitBtn1Click(Sender: TObject);
begin
  gravarIni('SSFacil','database',Edit1.Text);
  gravarIni('SSFacil','username',Edit2.Text);
  gravarIni('SSFacil','password',Encoder64.EncodeString(Edit3.Text));

  gravarIni('NFeConfig','database',Edit22.Text);
  gravarIni('NFeConfig','username',Edit23.Text);
  gravarIni('NFeConfig','password',Encoder64.EncodeString(Edit24.Text));
  gravarIni('NFeConfig','LocalExe',EdtLocalExeNFeconfig.Text);

  gravarIni('Bando de dados','database',Edit6.Text);
  gravarIni('Bando de dados','username',Edit5.Text);
  gravarIni('Bando de dados','password',Encoder64.EncodeString(Edit4.Text));

  gravarIni('FDBUpdate','database',Edit17.Text);
  gravarIni('FDBUpdate','username',Edit16.Text);
  gravarIni('FDBUpdate','password',Encoder64.EncodeString(Edit15.Text));

  //Grava parâmetros ftp
  gravarIni('FTPUpdate','FTP',Edit7.Text);
  gravarIni('FTPUpdate','Username',Edit8.Text);
  gravarIni('FTPUpdate','Password',Encoder64.EncodeString(Edit10.Text));
  gravarIni('FTPUpdate','PastaCliente',Edit9.Text);
  gravarIni('FTPUpdate','PastaServidorFTP',Edit11.Text);
  gravarIni('FTPUpdate','ArquivoExe',Edit25.Text);
  gravarIni('FTPUpdate','ArquivoZip',Edit13.Text);
  gravarIni('FTPUpdate','DB',Edit12.Text);
  if CheckBox1.Checked then
    gravarIni('FTPUpdate','Passivo','S')
  else
    gravarIni('FTPUpdate','Passivo','N');
  gravarIni('FTPUpdate','RelPrefixo',Edit26.Text);
  gravarIni('FTPUpdate','RelPasta',Edit27.Text);

  //Grava parâmetros lan
  gravarIni('LANUpdate','LOCAL',Edit14.Text);

  //Grava parâmtros BKP
  gravarIni('BackUp','Arquivo',Edit18.Text);
  gravarIni('BackUp','FTP',Edit19.Text);
  gravarIni('BackUp','Username',Edit20.Text);
  gravarIni('BackUp','Password',Encoder64.EncodeString(Edit21.Text));
  gravarIni('BackUp','Hora',(RzDateTimeEdit1.Text));

  Close;
end;

procedure TfrmConfigEdit.gravarIni(Tabela, Campo, Valor: String);
var
  ServerIni: TIniFile;
begin
  ServerIni := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  ServerIni.WriteString(Tabela,Campo,Valor);
  ServerIni.UpdateFile;
  ServerIni.Free;
end;

procedure TfrmConfigEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
