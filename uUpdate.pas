//http://www.devmedia.com.br/artigo-clube-delphi-80-atualizacao-automatica-de-aplicacoes-via-ftp/11103
//versao 04/09/2014
//versao 24/05/2019 - atualizar banco via ftp e executáveis

unit uUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, ComCtrls, StdCtrls,
  Buttons, IniFiles, Gauges, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdFTP, IdCoder, IdCoder3to4,
  IdCoderMIME, ZipMstr, CheckLst, DBXpress, SqlExpr, RzPanel, NxCollection;

type
  threadFTP = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure conectarFtp;
  end;

  TfrmUpdate = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    Label2: TLabel;
    ftpUpdate: TIdFTP;
    Decoder64: TIdDecoderMIME;
    ZipMaster1: TZipMaster;
    Label1: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    Gauge1: TGauge;
    Shape1: TShape;
    Label3: TLabel;
    CheckListBox1: TCheckListBox;
    lblVersaoNFEBD: TLabel;
    gbxVendedor: TRzGroupBox;
    Label4: TLabel;
    lblVersaoLocal: TLabel;
    lblVersaoAtualizacao: TLabel;
    Label6: TLabel;
    btnAtualizar: TNxButton;
    btnCancelar: TNxButton;
    btnBanco: TNxButton;
    procedure btnAtualizarClick(Sender: TObject);
    procedure ftpUpdateStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
    procedure ftpUpdateWork(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
    procedure ftpUpdateDisconnected(Sender: TObject);
    procedure ftpUpdateWorkBegin(Sender: TObject; AWorkMode: TWorkMode; const AWorkCountMax: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnBancoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
//    bytes_transf: longword;
    arquivo_local, arquivo_servidor: String;
    procedure Descompacta(vArquivo: String);
    function lerIni(tabela_ini, campo_ini: string): string;

    procedure prc_Atualiza_Banco_Local;

  public
    { Public declarations }
  end;

var
  frmUpdate: TfrmUpdate;

implementation

uses uMenu, uDmDatabase, DmdDatabase_NFeBD;

{$R *.dfm}

{ threadFTP }

procedure threadFTP.conectarFtp;
begin
end;

procedure threadFTP.Execute;
var
  vArq, vArq2 : String;
begin
  with frmUpdate do
  begin
    Gauge1.Visible := True;

    ftpupdate.Host     := lerini('FTPUpdate','FTP');
    ftpupdate.Username := lerini('FTPUpdate','Username');
    ftpupdate.Password := Decoder64.DecodeString(lerini('FTPUpdate','Password'));
    if lerini('FTPUpdate','Passivo') = 'S' then
      ftpupdate.Passive := true
    else
      ftpupdate.Passive := false;

    ftpupdate.Connect(true);

    ftpupdate.changeDir(lerini('FTPUpdate','PastaServidorFTP'));
    ftpupdate.list(nil);
    tamanho_arquivo := ftpupdate.Size(lerini('FTPUpdate','ArquivoZip'));

  //salvar arquivo original como new
  //ftpupdate.get(lerini('FTPUpdate','Arquivo'),Copy(arquivo_local,1,Length(arquivo_local)-4)+'.new',true);

    if CheckListBox1.Checked[0] then   //SSFacil
    begin
      Gauge1.ForeColor   := $00804000;
      Shape1.Brush.Color := $00804000;
      Label3.Caption     := 'SSFácil';
      ftpupdate.get(lerini('FTPUpdate','ArquivoZip'),Copy(arquivo_local,1,Length(arquivo_local)-4)+'.zip',true);

      //comparar tamanho original com baixado
      if tamanho_arquivo = fMenu.DSiFileSize(Copy(arquivo_local,1,Length(arquivo_local)-4)+'.zip') then
      begin
        RenameFile(arquivo_local,Copy(arquivo_local,1,Length(arquivo_local)-3)+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
        Descompacta(Copy(arquivo_local,1,Length(arquivo_local)-4)+'.zip');

        //Aplica a data do arquivo original do ftp no arquivo baixado
        FileSetDate(arquivo_local,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate));
      end;
    end;


    if CheckListBox1.Checked[2] then   //Cupom Fiscal
    begin
      Gauge1.ForeColor   := $004080FF;
      Shape1.Brush.Color := $004080FF;
      Label3.Caption     := 'Cupom Fiscal';
      ftpupdate.get('ssCupomFiscal.zip','ssCupomFiscal.zip',true);
      tamanho_arquivo := ftpupdate.Size('ssCupomFiscal.zip');

      //comparar tamanho original com baixado
      if tamanho_arquivo = fMenu.DSiFileSize(Copy('ssCupomFiscal.exe',1,Length('ssCupomFiscal.exe')-4)+'.zip') then
      begin
        RenameFile('ssCupomFiscal.exe',Copy('ssCupomFiscal.exe',1,Length('ssCupomFiscal.exe')-3)+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
        Descompacta('ssCupomFiscal.zip');

        //Aplica a data do arquivo original do ftp no arquivo baixado
        FileSetDate(arquivo_local,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate));
      end;
    end;

    if CheckListBox1.Checked[1] then  //Parâmetros
    begin
      Gauge1.ForeColor   := $0080FF80;
      Shape1.Brush.Color := $0080FF80;
      Label3.Caption     := 'Parâmetros';
      ftpupdate.get('SSFacil_Parametros.zip','SSFacil_Parametros.zip',true);
      tamanho_arquivo := ftpupdate.Size('SSFacil_Parametros.zip');

      //comparar tamanho original com baixado
      if tamanho_arquivo = fMenu.DSiFileSize(Copy('SSFacil_Parametros.exe',1,Length('SSFacil_Parametros.exe')-4)+'.zip') then
      begin
        RenameFile('SSFacil_Parametros.exe',Copy('SSFacil_Parametros.exe',1,Length('SSFacil_Parametros.exe')-3)+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
        Descompacta('SSFacil_Parametros.zip');

        //Aplica a data do arquivo original do ftp no arquivo baixado
        FileSetDate(arquivo_local,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate));
      end;
    end;

    if CheckListBox1.Checked[4] then   //Produção
    begin
      Gauge1.ForeColor   := $00FF80FF;
      Shape1.Brush.Color := $00FF80FF;
      Label3.Caption     := 'Produção';
      ftpupdate.get('SSFacil_Prod.zip','SSFacil_Prod.zip',true);
      tamanho_arquivo := ftpupdate.Size('SSFacil_Prod.zip');

      //comparar tamanho original com baixado
      if tamanho_arquivo = fMenu.DSiFileSize(Copy('SSFacil_Prod.exe',1,Length('SSFacil_Prod.exe')-4)+'.zip') then
      begin
        RenameFile('SSFacil_Prod.exe',Copy('SSFacil_Prod.exe',1,Length('SSFacil_Prod.exe')-3)+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
        Descompacta('SSFacil_Prod.zip');

        //Aplica a data do arquivo original do ftp no arquivo baixado
        FileSetDate(arquivo_local,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate));
      end;
    end;

    if CheckListBox1.Checked[3] then   //OS
    begin
      Gauge1.ForeColor   := $00FFFF80;
      Shape1.Brush.Color := $00FFFF80;
      Label3.Caption     := 'Ordem Serviço';
      ftpupdate.get('SSFacil_OS.zip','SSFacil_OS.zip',true);
      tamanho_arquivo := ftpupdate.Size('SSFacil_OS.zip');

      //comparar tamanho original com baixado
      if tamanho_arquivo = fMenu.DSiFileSize(Copy('SSFacil_OS.exe',1,Length('SSFacil_OS.exe')-4)+'.zip') then
      begin
        RenameFile('SSFacil_OS.exe',Copy('SSFacil_OS.exe',1,Length('SSFacil_OS.exe')-3)+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
        Descompacta('SSFacil_OS.zip');

        //Aplica a data do arquivo original do ftp no arquivo baixado
        FileSetDate(arquivo_local,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate));
      end;
    end;

    if CheckListBox1.Checked[6] then   //Utilitários
    begin
      Gauge1.ForeColor   := $00804000;
      Shape1.Brush.Color := $00804000;
      Label3.Caption     := 'Utilitários';
      ftpupdate.get('SSUtilitarios.zip','SSUtilitarios.zip',true);
      tamanho_arquivo := ftpupdate.Size('SSUtilitarios.zip');

      //comparar tamanho original com baixado
      if tamanho_arquivo = fMenu.DSiFileSize(Copy('SSUtilitarios.exe',1,Length('SSUtilitarios.exe')-4)+'.zip') then
      begin
        RenameFile('SSUtilitarios.exe',Copy('SSUtilitarios.exe',1,Length('SSUtilitarios.exe')-3)+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
        Descompacta('SSUtilitarios.zip');

        //Aplica a data do arquivo original do ftp no arquivo baixado
        FileSetDate(arquivo_local,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate));
      end;
    end;

    if CheckListBox1.Checked[7] then   //ssBackUp_Solo
    begin
      Gauge1.ForeColor   := clFuchsia;
      Shape1.Brush.Color := clFuchsia;
      Label3.Caption     := 'ssBackUp_Solo';
      ftpupdate.get('ssBackUp_Solo.zip','ssBackUp_Solo.zip',true);
      tamanho_arquivo := ftpupdate.Size('ssBackUp_Solo.zip');

      //comparar tamanho original com baixado
      if tamanho_arquivo = fMenu.DSiFileSize(Copy('ssBackUp_Solo.exe',1,Length('ssBackUp_Solo.exe')-4)+'.zip') then
      begin
        RenameFile('ssBackUp_Solo.exe',Copy('ssBackUp_Solo.exe',1,Length('ssBackUp_Solo.exe')-3)+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
        Descompacta('ssBackUp_Solo.zip');

        //Aplica a data do arquivo original do ftp no arquivo baixado
        FileSetDate(arquivo_local,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate));
      end;
    end;

    //10/01/2020
    if CheckListBox1.Checked[8] then   //BuscaIBPT
    begin
      Gauge1.ForeColor   := clYellow;
      Shape1.Brush.Color := clYellow;
      Label3.Caption     := 'BuscaIBPT';
      ftpupdate.get('BuscaIBPT.zip','BuscaIBPT.zip',true);
      tamanho_arquivo := ftpupdate.Size('BuscaIBPT.zip');

      //comparar tamanho original com baixado
      if tamanho_arquivo = fMenu.DSiFileSize(Copy('BuscaIBPT.exe',1,Length('BuscaIBPT.exe')-4)+'.zip') then
      begin
        RenameFile('BuscaIBPT.exe',Copy('BuscaIBPT.exe',1,Length('BuscaIBPT.exe')-3)+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
        Descompacta('BuscaIBPT.zip');

        //Aplica a data do arquivo original do ftp no arquivo baixado
        FileSetDate(arquivo_local,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate));
      end;
    end;

    //10/01/2020
    if CheckListBox1.Checked[9] then   //SSNFCe
    begin
      Gauge1.ForeColor   := clYellow;
      Shape1.Brush.Color := clYellow;
      Label3.Caption     := 'SSNFCe';
      ftpupdate.get('SSNFCe.zip','SSNFCe.zip',true);
      tamanho_arquivo := ftpupdate.Size('SSNFCe.zip');

      //comparar tamanho original com baixado
      if tamanho_arquivo = fMenu.DSiFileSize(Copy('SSNFCe.exe',1,Length('SSNFCe.exe')-4)+'.zip') then
      begin
        RenameFile('SSNFCe.exe',Copy('SSNFCe.exe',1,Length('SSNFCe.exe')-3)+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
        Descompacta('SSNFCe.zip');

        //Aplica a data do arquivo original do ftp no arquivo baixado
        FileSetDate(arquivo_local,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate));
      end;
    end;

    //15/01/2020
    if CheckListBox1.Checked[10] then  //Consulta CNPJ  
    begin
      Gauge1.ForeColor   := clYellow;
      Shape1.Brush.Color := clYellow;
      Label3.Caption     := 'ConsultaCNPJ.zip';
      ftpupdate.get('ConsultaCNPJ.zip','ConsultaCNPJ.zip',true);
      tamanho_arquivo := ftpupdate.Size('ConsultaCNPJ.zip');

      //comparar tamanho original com baixado
      if tamanho_arquivo = fMenu.DSiFileSize(Copy('ConsultaCNPJ.exe',1,Length('ConsultaCNPJ.exe')-4)+'.zip') then
      begin
        RenameFile('ConsultaCNPJ.exe',Copy('ConsultaCNPJ.exe',1,Length('ConsultaCNPJ.exe')-3)+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
        Descompacta('ConsultaCNPJ.zip');

        //Aplica a data do arquivo original do ftp no arquivo baixado
        FileSetDate(arquivo_local,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate));
      end;

      vArq  := 'ConsultaCNPJ.dll';
      vArq2 := 'ConsultaCNPJ_dll.' + FormatDateTime('YYYY-MM-DD_HH-NN',Now);

      Gauge1.ForeColor   := clYellow;
      Shape1.Brush.Color := clYellow;
      Label3.Caption     := 'ConsultaCNPJ.dll';
      CopyFile(pAnsiChar(vArq),pAnsiChar(vArq2),true);
      ftpupdate.get('ConsultaCNPJ.dll','ConsultaCNPJ.dll',true);
      tamanho_arquivo := ftpupdate.Size('ConsultaCNPJ.dll');

      //comparar tamanho original com baixado
      //if tamanho_arquivo = fMenu.DSiFileSize(Copy('ConsultaCNPJ.exe',1,Length('ConsultaCNPJ.exe')-4)+'.zip') then
      begin
        //RenameFile('ConsultaCNPJ.dll',Copy('ConsultaCNPJ.dll',1,Length('ConsultaCNPJ.dll')-4)+ '_dll.'+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
        RenameFile('ConsultaCNPJ.dll',Copy('ConsultaCNPJ.dll',1,Length('ConsultaCNPJ.dll')-3)+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
        //Descompacta('ConsultaCNPJ.zip');

        //Aplica a data do arquivo original do ftp no arquivo baixado
        FileSetDate(arquivo_local,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate));
      end;

    end;

    //18/05/2020
    if CheckListBox1.Checked[11] then   //SSIntegradorPDV
    begin
      Gauge1.ForeColor   := clMaroon;
      Shape1.Brush.Color := clMaroon;
      Label3.Caption     := 'SSIntegradorPDV';
      ftpupdate.get('SSIntegradorPDV.zip','SSIntegradorPDV.zip',true);
      tamanho_arquivo := ftpupdate.Size('SSIntegradorPDV.zip');

      //comparar tamanho original com baixado
      if tamanho_arquivo = fMenu.DSiFileSize(Copy('SSIntegradorPDV.exe',1,Length('SSIntegradorPDV.exe')-4)+'.zip') then
      begin
        RenameFile('SSIntegradorPDV.exe',Copy('SSIntegradorPDV.exe',1,Length('SSIntegradorPDV.exe')-3)+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
        Descompacta('SSIntegradorPDV.zip');

        //Aplica a data do arquivo original do ftp no arquivo baixado
        FileSetDate(arquivo_local,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate));
      end;
    end;

    //18/05/2020
    if CheckListBox1.Checked[12] then   //SSIntegração Contábil
    begin
      Gauge1.ForeColor   := clPurple;
      Shape1.Brush.Color := clPurple;
      Label3.Caption     := 'SSIntegracao';
      ftpupdate.get('SSIntegracao.zip','SSIntegracao.zip',true);
      tamanho_arquivo := ftpupdate.Size('SSIntegracao.zip');

      //comparar tamanho original com baixado
      if tamanho_arquivo = fMenu.DSiFileSize(Copy('SSIntegracao.exe',1,Length('SSIntegracao.exe')-4)+'.zip') then
      begin
        RenameFile('SSIntegracao.exe',Copy('SSIntegracao.exe',1,Length('SSIntegracao.exe')-3)+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
        Descompacta('SSIntegracao.zip');

        //Aplica a data do arquivo original do ftp no arquivo baixado
        FileSetDate(arquivo_local,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate));
      end;
    end;

    if CheckListBox1.Checked[5] then   //MDFe
    begin
      Gauge1.ForeColor   := $00FF80FF;
      Shape1.Brush.Color := $00FF80FF;
      Label3.Caption     := 'Manifestos';
      ftpupdate.get('SSFacil_MDFe.zip','SSFacil_MDFe.zip',true);
      tamanho_arquivo := ftpupdate.Size('SSFacil_MDFe.zip');

      //comparar tamanho original com baixado
      if tamanho_arquivo = fMenu.DSiFileSize(Copy('SSFacil_MDFe.exe',1,Length('SSFacil_MDFe.exe')-4)+'.zip') then
      begin
        RenameFile('SSFacil_MDFe.exe',Copy('SSFacil_MDFe.exe',1,Length('SSFacil_MDFe.exe')-3)+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
        Descompacta('SSFacil_MDFe.zip');

        //Aplica a data do arquivo original do ftp no arquivo baixado
        FileSetDate(arquivo_local,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate));
      end;
    end;

    if 1 = 1 then   //Painel de Controle
    begin
      Gauge1.ForeColor   := clGreen;
      Shape1.Brush.Color := clGreen;
      Label3.Caption     := 'Painel de Controle';
      ftpupdate.get('ssPainelControle.zip','ssPainelControle.zip',true);
      tamanho_arquivo := ftpupdate.Size('ssPainelControle.zip');

      //comparar tamanho original com baixado
      if tamanho_arquivo = fMenu.DSiFileSize(Copy('ssPainelControle.exe',1,Length('ssPainelControle.exe')-4)+'.zip') then
      begin
        RenameFile('ssPainelControle.exe',Copy('ssPainelControle.exe',1,Length('ssPainelControle.exe')-3)+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
        Descompacta('ssPainelControle.zip');

        //Aplica a data do arquivo original do ftp no arquivo baixado
        FileSetDate(arquivo_local,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate));
      end;
    end;

    Gauge1.Visible := False;

    Sleep(2000);
    btnCancelar.SetFocus;
    btnCancelar.Caption := 'Fechar';

    Label3.Caption  := 'Todos os programas selecionados atualizados';


//    ShowMessage('Concluído!');
    ftpupdate.Disconnect;
  end;

  //Estrutura para conexão
{
  IdFTP1.Disconnect();

  IdFTP1.Host := 'ftp.abc71.com.br';
  IdFTP1.Port := 21;
  IdFTP1.Username := 'usuario_para_login';
  IdFTP1.Password := 'senha';
  IdFTP1.Passive := false; // usa modo ativo
  IdFTP1.RecvBufferSize := 8192;
  try
  // Espera até 10 segundos pela conexão
  IdFTP1.Connect(true, 10000);
  except
  on E: Exception do
  _Erro = E.Message;
  end;
}
//Comando para enviar
  //IdFTP1.Put (AFileName, ADstFileName, false);

//Comando para receber
  //IdFTP1.Get (AFileName, ADstFileName, true, false);
end;

procedure TfrmUpdate.btnAtualizarClick(Sender: TObject);
begin
  arquivo_local := lerIni('FTPUpdate','PastaCliente')+ '\' + lerini('FTPUpdate','ArquivoExe');
  btnAtualizar.Enabled := False;

  ftpUpdate.Host     := lerini('FTPUpdate','FTP');
  ftpUpdate.Username := lerini('FTPUpdate','Username');
  ftpUpdate.Password := Decoder64.DecodeString(lerini('FTPUpdate','Password'));
  if lerini('FTPUpdate','Passivo') = 'S' then
    ftpupdate.Passive := true
  else
    ftpupdate.Passive := false;

  ftpupdate.Connect(true);

  ftpupdate.changedir(lerini('FTPUpdate','PastaServidorFTP'));
  ftpupdate.list(nil);

  if FileExists(lerini('FTPUpdate','PastaCliente')+ '\' + lerini('FTPUpdate','Arquivo')) then
  begin
    if (FormatDateTime('dd/mm/yyyy HH:mm',FileDateToDateTime(FileAge(arquivo_local))) <
       FormatDateTime('dd/mm/yyyy HH:mm',ftpUpdate.DirectoryListing.Items[0].ModifiedDate)) or (1 = 1) then
    begin
      if 1 = 1 then //sempre baixa versão do servidor
      begin
        ftpupdate.Disconnect;
        threadFTP.Create(false);
      end
      else
        ftpupdate.Disconnect;
    end
    else
    begin
      MessageDlg('O software já está com versão atualizada!',mtInformation,[mbOk],0);
      ftpupdate.Disconnect;
      Close;
    end;
  end
  else
//////
  begin
    try
      tamanho_arquivo := ftpupdate.Size(lerini('FTPUpdate','Arquivo'));
      ftpupdate.get(lerini('FTPUpdate','Arquivo'),lerini('FTPUpdate','PastaCliente') +'\'+lerini('FTPUpdate','Arquivo'),true);
      ftpupdate.Disconnect;
    except
      ftpupdate.Disconnect;
    end;
  end;
end;

procedure TfrmUpdate.ftpUpdateStatus(ASender: TObject;
  const AStatus: TIdStatus; const AStatusText: String);
begin
 case aStatus of
   hsResolving: statusbar1.Panels[0].text     := 'Resolvendo...';
   hsConnecting: statusbar1.Panels[0].text    := 'Conectando...';
   hsConnected: statusbar1.Panels[0].text     := 'Conectado ao Servidor FTP! Aguarde...';
   hsDisconnecting: statusbar1.Panels[0].text := 'Desconectando!';
   hsDisconnected: statusbar1.Panels[0].text  := 'Concluído e desconectado!';
   ftpTransfer: statusbar1.Panels[0].text     := 'Transferindo...';
   ftpReady: statusbar1.Panels[0].text        := 'Lendo...';
   ftpAborted: statusbar1.Panels[0].text      := 'Abortado!';
   else
     statusbar1.Panels[0].text:= AStatusText;
  end;//fim do case
end;

procedure TfrmUpdate.ftpUpdateWork(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
var
  contador,kbTotal, kbTransmitidos, kbFaltantes: Integer;
  Status_trans: String;
  Totaltempo: TDateTime;
  H, M, sec, MS: Word;
  DLTime, media: Double;
begin
  kbTotal    := tamanho_arquivo div 1024;
  Totaltempo := Now - STime;
  DecodeTime(Totaltempo, H, M, Sec, MS);
  Sec    := Sec + M * 60 + H * 3600;
  DLTime := Sec + MS / 1000;
  KbTransmitidos := AWorkCount div 1024;
//  kbFaltantes    := kbTotal - kbTransmitidos;
  statusbar1.Panels[2].text := 'Transferidos: '+ formatfloat('##,###,##0', kbTransmitidos ) +
                               ' Kb de ' + formatfloat('##,###,##0', kbTotal) + ' Kb';
  media:=(100/tamanho_arquivo)*AWorkCount;
  if DLTime > 0 then
  begin
    tempo_medio  := (AWorkCount / 1024) / DLTime;
    Status_trans := Format('%2d:%2d:%2d', [Sec div 3600, (Sec div 60) mod 60, Sec mod 60]);
    Status_trans := 'Tempo de download ' + Status_trans;
  end;
  Status_trans   := 'Taxa de Transferência: '+FormatFloat('0.00 KB/s', tempo_medio) + '; ' + Status_trans;
  statusbar1.Panels[1].text := Status_trans;
  Application.ProcessMessages;
  contador        := trunc(media);
  gauge1.Progress := contador;
end;

procedure TfrmUpdate.ftpUpdateDisconnected(Sender: TObject);
begin
  gauge1.AddProgress(100);
  Screen.Cursor := crDefault;
  statusbar1.Panels[0].text := 'Download concluído!! Desconectado do servidor FTP!';
end;

procedure TfrmUpdate.ftpUpdateWorkBegin(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
  Stime       := now;
  tempo_medio := 0;
end;

procedure TfrmUpdate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

function TfrmUpdate.lerIni(tabela_ini, campo_ini: string): string;
var
  ServerIni: TIniFile;
begin
  ServerIni := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
  result    := ServerIni.ReadString(tabela_ini,campo_ini,'');
  ServerIni.Free;
end;

procedure TfrmUpdate.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmUpdate.Descompacta(vArquivo: String);
begin
  ZipMaster1.Dll_Load := True;
  with ZipMaster1 do
  begin
    ZipFileName := vArquivo;
    if Count = 0 then
    begin
      ShowMessage('Error - nenhum arquivo no Zip!');
      Exit;
    end;
    FSpecArgs.Add('*.*');
    ExtrBaseDir := GetCurrentDir;
    ExtrOptions := ExtrOptions + [ExtrOverwrite];
    Extract;
//    ShowMessage('Arquivos extraídos = ' + IntToStr(SuccessCnt) + '!');
  end;
  ZipMaster1.Dll_Load := False;
end;

procedure TfrmUpdate.btnBancoClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  //dmDatabase.prcAtualizaBanco;
  prc_Atualiza_Banco_Local;

  FormShow(Sender);
  Screen.Cursor := crDefault;
  ShowMessage('Concluído!');
end;

procedure TfrmUpdate.FormShow(Sender: TObject);
begin
  dmDatabase.sqVersaoAtual.Open;
  lblVersaoAtualizacao.Caption := FormatFloat('0000',dmDatabase.fncVersoDoAtualiza);
  lblVersaoLocal.Caption       := FormatFloat('0000',dmDatabase.sqVersaoAtualVERSAO_BANCO.AsInteger);
  dmDatabase.sqVersaoAtual.Close;
end;

procedure TfrmUpdate.prc_Atualiza_Banco_Local;
var
  DelimiterPos: Integer;
  S: WideString;
  Command: WideString;
  vFlag, vErro: Boolean;
  F: TextFile;
  arqLog: String;
  vID_Versao: Integer;
  vSQL_Ant: WideString;
  ID, ID2: TTransactionDesc;
  sds: TSQLDataSet;
  vFlag2: Integer;
  vMicroAtual: Boolean;
  i : Integer;
  i2 : Integer;
  ctVersao : String;
  vMSGErro : String;
begin
  arqLog := '';
  vErro  := False;
  arqLog := 'FDBUpdate_' + FormatDateTime('YYYYMMDD',Date) +  '_' + FormatDateTime('HHMMSS',Time) +  '.log';
  AssignFile(F,arqLog);
  ReWrite(F);

  vMSGErro := '';
  ctVersao := dmDatabase.sdsVersao.CommandText;
  dmDatabase.sqVersaoAtual.Close;
  dmDatabase.sqVersaoAtual.Open;
  i := dmDatabase.sqVersaoAtualVERSAO_BANCO.AsInteger;
  dmDatabase.qMax.Close;
  dmDatabase.qMax.Open;
  i2 := dmDatabase.qMaxID.AsInteger;
  i  := i + 1;
  while i <= i2 do
  begin
    lblVersaoLocal.Caption := FormatFloat('0000',i);
    lblVersaoLocal.Refresh;
    Refresh;
    Sleep(1000);
    Application.ProcessMessages;

    dmDatabase.cdsVersao.close;
    dmDatabase.sdsVersao.CommandText := ctVersao + ' AND ID = ' + IntToStr(i) + ' AND PROGRAMA_ID = 1 ';
    dmDatabase.cdsVersao.Open;
    if not dmDatabase.cdsVersao.IsEmpty then
    begin
      try
        sds := TSQLDataSet.Create(nil);
        sds.SQLConnection := dmDatabase.scoDados;
        sds.NoMetadata    := True;
        sds.GetMetadata   := False;
        vFlag2 := 1;

        S := dmDatabase.cdsVersaoSCRIPT.AsString;
        vFlag := True;
        while vFlag do
        begin
          DelimiterPos := Pos('}', S);
          if DelimiterPos = 0 then
            DelimiterPos := Length(S);
          Command:= Copy(S, 1, DelimiterPos - 1);
          if pos('COMMIT',UpperCase(Command)) <= 0 then
            vSQL_Ant := Command;

          dmDatabase.sdsExec.CommandText := (Command);
          if trim(dmDatabase.sdsExec.CommandText) <> '' then
          begin
            ID.TransactionID  := 99;
            ID.IsolationLevel := xilREADCOMMITTED;
            dmDatabase.scoDados.StartTransaction(ID);
            try
              dmDatabase.sdsExec.ExecSQL(True);
              dmDatabase.scoDados.Commit(ID);
            except
              WriteLn(F,'----------------------------');
              WriteLn(F,'Versão: ' + dmDatabase.cdsVersaoID.AsString + ' = ' + vSQL_Ant);
              vErro := True;
              if trim(vMSGErro) = '' then
                vMSGErro := 'Verificar erro de script no arquivo de log: ' + arqLog;
              vMSGErro := vMSGErro + #13 + 'Versão : ' + FormatFloat('0000',dmDatabase.cdsVersaoID.AsInteger);
              dmDatabase.scoDados.Rollback(ID);
            end;
          end;
          Delete(S, 1, DelimiterPos);
          if Length(S) = 0 then
            vFlag := False;
        end;
        dmDatabase.sdsExec.CommandText := ('UPDATE PARAMETROS SET VERSAO_BANCO = ' + dmDatabase.cdsVersaoID.AsString);
        dmDatabase.sdsExec.ExecSQL(True);

      finally
        sds.Close;
        FreeAndNil(sds);
      end;
    end;

    i := i + 1;
    if i <= i2 then
    begin
      dmDatabase.scoDados.Connected := False;
      dmDatabase.scoDados.Connected := True;
    end;
  end;

  if trim(arqLog) <> '' then
    CloseFile(F);
  if not(vErro) then
    DeleteFile(arqLog);

  if vErro then
    MessageDlg(vMSGErro,mtError,[mbOk],0);

  dmDatabase.cdsVersao.Close;
  dmDatabase.scoDados.Connected := False;
  dmDatabase.sqVersaoAtual.Close;
  dmDatabase.scoAtualiza.Connected := False;
end;

end.
