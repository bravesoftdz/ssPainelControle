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
    arquivo_local, arquivo_servidor: String;
    vPastaNFeConfig : String;

    procedure Descompacta(vArquivo,Pasta: String);
    function lerIni(tabela_ini, campo_ini: string): string;

    procedure prc_Atualiza_Banco_Local;

    procedure prc_Baixar_Programa(NomePrograma : String ; ContCor : Integer);

  public
    { Public declarations }
  end;

var
  frmUpdate: TfrmUpdate;

implementation

uses uMenu, uDmDatabase, DmdDatabase_NFeBD, StrUtils;

{$R *.dfm}

{ threadFTP }

const
  vPrograma : array [0..18] of String  = ('SSFacil.zip','SSFacil_Parametros.zip','ssCupomFiscal.zip','SSFacil_OS.zip','SSFacil_Prod.zip','SSFacil_MDFe.zip',
                                          'SSUtilitarios.zip','ssBackUp_Solo.zip','BuscaIBPT.zip','SSNFCe.zip','ConsultaCNPJ.zip','ConsultaCNPJ_DLL.zip',
                                          'SSIntegradorPDV.zip','SSIntegracao.zip','ImpressaoCozinha.zip','ManifestoNFe.zip','xtrSSFacil.zip',
                                          'xtrNFeConfig.zip','NFeConfig.zip');

  vCor  : array [1..3] of TColor = ($00804000,$004080FF,$0080FF80);

procedure threadFTP.conectarFtp;
begin
end;

procedure threadFTP.Execute;
var
  vArq, vArq2 : String;
  i : Integer;
  iCor : Integer;
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

    //11/06/2020
    iCor := 0;
    for i := 0 To CheckListBox1.Count - 1 do
    begin
      if CheckListBox1.Checked[i] then
      begin
        Label3.Caption := CheckListBox1.Items.Strings[i];
        iCor := iCor + 1;
        if iCor > 3 then
          iCor := 1;
        prc_Baixar_Programa(vPrograma[i],iCor);
      end;
    end;
    prc_Baixar_Programa('ssPainelControle.zip',1);

    Gauge1.Visible := False;

    Sleep(2000);
    btnCancelar.SetFocus;
    btnCancelar.Caption := 'Fechar';

    Label3.Caption  := 'Todos os programas selecionados atualizados';

    ftpupdate.Disconnect;
  end;
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

  vPastaNFeConfig := lerini('NFeConfig','LocalExe');
  if copy(vPastaNFeConfig,Length(vPastaNFeConfig),1) <> '\' then
    vPastaNFeConfig := vPastaNFeConfig + '\';

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

procedure TfrmUpdate.Descompacta(vArquivo, Pasta: String);
begin
  ZipMaster1.Dll_Load := True;
  with ZipMaster1 do
  begin                    //mudar pasta  aqui 15/06/2020
    if trim(Pasta) <> '' then
    begin
      //ExtrBaseDir := Pasta
      ExtrBaseDir := Pasta;
      ZipFileName := Pasta + vArquivo;
    end
    else
    begin
      ExtrBaseDir := GetCurrentDir;
      ZipFileName := vArquivo;
    end;

    if Count = 0 then
    begin
      ShowMessage('Error - nenhum arquivo no Zip!');
      Exit;
    end;
    FSpecArgs.Add('*.*');
    {if trim(Pasta) <> '' then
      ExtrBaseDir := Pasta
    else
      ExtrBaseDir := GetCurrentDir;}
    ExtrOptions := ExtrOptions + [ExtrOverwrite] + [ExtrDirNames];
    Extract;
    //(ExtrDirNames, ExtrOverWrite, ExtrFreshen, ExtrUpdate,
    //ExtrTest, ExtrForceDirs, ExtrNTFS);

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

procedure TfrmUpdate.prc_Baixar_Programa(NomePrograma : String ; ContCor : Integer);
var
  i: Integer;
  vNomeAux : String;
  vXtr : Boolean;
  vArqLocalAux : String;
  x : String;
  vPastaAux : String;
begin
  //Gauge1.ForeColor   := $004080FF;
  //Shape1.Brush.Color := $004080FF;
  Gauge1.ForeColor   := vCor[ContCor];
  Shape1.Brush.Color := vCor[ContCor];

  vPastaAux := '';
  i := Pos('.',NomePrograma);
  vNomeAux := copy(NomePrograma,1,i-1);
  vXtr := (Posex('xtr',vNomeAux) > 0);

  if Posex('NFeConfig',vNomeAux) > 0 then
  begin
    if not DirectoryExists(vPastaNFeConfig) then
    begin
      MessageDlg('Não foi configurado ou encontrado a pasta do NFeConfig!',mtInformation,[mbOk],0);
      exit;
    end;
    vPastaAux := vPastaNFeConfig;
  end;

  try
    //if Posex('NFeConfig',vNomeAux) > 0 then
      ftpupdate.get(NomePrograma,vPastaAux + NomePrograma,true);
    //else
     // ftpupdate.get(NomePrograma,NomePrograma,true);
    tamanho_arquivo := ftpupdate.Size(NomePrograma);
    //comparar tamanho original com baixado
    //if tamanho_arquivo = fMenu.DSiFileSize(Copy(vNomeAux + '.exe',1,Length(vNomeAux + '.exe')-4)+'.zip') then
    begin
      if vXtr then
        Renamefile(vPastaAux + 'xtr',vPastaAux + 'xtr' + '_' + FormatDateTime('YYYY-MM-DD_HH-NN',Now))
      else
        RenameFile(vPastaAux + vNomeAux + '.exe',vPastaAux + Copy(vNomeAux + '.exe',1,Length(vNomeAux + '.exe')-3)+ FormatDateTime('YYYY-MM-DD_HH-NN',Now));
      Descompacta(NomePrograma,vPastaAux);
      //Aplica a data do arquivo original do ftp no arquivo baixado

      if Posex('NFeConfig',vNomeAux) > 0 then
        FileSetDate(vPastaNFeConfig,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate))
      else
        FileSetDate(arquivo_local,DateTimeToFileDate(ftpupdate.DirectoryListing.Items[0].ModifiedDate));
    end;
  except
    on E: exception do
    begin
      ShowMessage('Erro: ' + E.Message + #13 + #13 +
                  'Erro ao atualizar ** ' + NomePrograma + ' ** ');
    end;
  end;

end;

end.
