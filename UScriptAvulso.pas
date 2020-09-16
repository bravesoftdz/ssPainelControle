unit UScriptAvulso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, NxCollection, ExtCtrls, SqlExpr;

type
  TfrmScriptAvulso = class(TForm)
    NxLabel1: TNxLabel;
    Memo1: TMemo;
    NxButton1: TNxButton;
    NxButton2: TNxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NxButton2Click(Sender: TObject);
    procedure NxButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmScriptAvulso: TfrmScriptAvulso;

implementation

uses uDmDatabase;

{$R *.dfm}

procedure TfrmScriptAvulso.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := Cafree;
end;

procedure TfrmScriptAvulso.NxButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmScriptAvulso.NxButton1Click(Sender: TObject);
var
  sds: TSQLDataSet;
begin
  sds := TSQLDataSet.Create(nil);
  try
    sds.SQLConnection := dmDatabase.scoDados;
    sds.NoMetadata    := True;
    sds.GetMetadata   := False;

    dmDatabase.sdsExec.Close;
    dmDatabase.sdsExec.CommandText := Memo1.Lines.Text;
    dmDatabase.sdsExec.ExecSQL(True);

    dmDatabase.sdsExec.Close;
    dmDatabase.sdsExec.CommandText := 'commit';
    dmDatabase.sdsExec.ExecSQL(True);

  finally
    FreeAndNil(sds);
  end;

  MessageDlg('Script Gerado!',mtInformation,[mbOk],0);
  Memo1.Lines.Clear;

  dmDatabase.cdsVersao.Close;
  dmDatabase.scoDados.Connected := False;
  dmDatabase.sqVersaoAtual.Close;
  dmDatabase.scoAtualiza.Connected := False;
end;

end.
