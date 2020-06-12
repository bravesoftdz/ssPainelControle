unit uMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, ToolWin, jpeg, ExtCtrls, ImgList;

type
  TfMenu = class(TForm)
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    Timer1: TTimer;
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function DSiFileSize(const fileName: string): int64;
  end;

var
  fMenu: TfMenu;
  //variaveis para tranferencia ftp
  tamanho_arquivo: LongWord;
  STime: TDateTime;
  tempo_medio: Double;

implementation

uses uUpdate, uBackUp, uFrmSobre, uConfigEdit;

{$R *.dfm}

procedure TfMenu.ToolButton1Click(Sender: TObject);
begin
  frmConfigEdit := TfrmConfigEdit.Create(Self);
  frmConfigEdit.ShowModal;
end;

procedure TfMenu.ToolButton2Click(Sender: TObject);
begin
  frmUpdate := TfrmUpdate.Create(Self);
  frmUpdate.ShowModal;
end;

procedure TfMenu.ToolButton3Click(Sender: TObject);
begin
  frmBackUp := TfrmBackUp.Create(Self);
  frmBackUp.ShowModal;
end;

procedure TfMenu.ToolButton4Click(Sender: TObject);
begin
  frmSobre := TfrmSobre.Create(Self);
  frmSobre.ShowModal;
end;

function TfMenu.DSiFileSize(const fileName: string): int64;
var
  fHandle: DWORD;
begin
  fHandle := CreateFile(PChar(fileName), 0, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if fHandle = INVALID_HANDLE_VALUE then
    Result := -1
  else try
    Int64Rec(Result).Lo := GetFileSize(fHandle, @Int64Rec(Result).Hi);

  finally CloseHandle(fHandle);
  end;
end;

procedure TfMenu.Timer1Timer(Sender: TObject);
begin
//  ToolButton3Click(Sender);
end;

end.
