unit uFrmSobre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls, IniFiles,
  ShellAPI;

type
  TfrmSobre = class(TForm)
    Memo1: TMemo;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSobre: TfrmSobre;

implementation

uses UMenu;

{$R *.dfm}

procedure TfrmSobre.FormCreate(Sender: TObject);
begin
  Memo1.Lines.Add('ServiSoft Inform�tica Ltda.');
  Memo1.Lines.Add('www.servisoft.com.br');
  Memo1.Lines.Add('Email: servisoft@servisoft.com.br');
  Memo1.Lines.Add('Fone: (51) 3598-6584 ');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('Suporte:');
  Memo1.Lines.Add(' Cleomar - Cel.: (51) 99942-0952');
  Memo1.Lines.Add(' Carlos - Cel.: (51) 99240-0477');
  Memo1.Lines.Add('Email: cleomar@servisoft.com.br');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('');
  Memo1.Lines.Add('Vers�o 1.0.1 10/01/2020');
//  Memo1.Lines.Add('Vers�o: ' + GetBuildInfo(GetCurrentDir + '\SSFacil.EXE'));
end;

//http://www.planetadelphi.com.br/artigo/143/atualizacao-pratica-de-seus-aplicativos/

end.
