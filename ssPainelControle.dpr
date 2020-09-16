program ssPainelControle;

uses
  Forms,
  uMenu in 'uMenu.pas' {fMenu},
  uUpdate in 'uUpdate.pas' {frmUpdate},
  uBackUp in 'uBackUp.pas' {frmBackUp},
  uFrmSobre in 'uFrmSobre.pas' {frmSobre},
  uConfigEdit in 'uConfigEdit.pas' {frmConfigEdit},
  uDmDatabase in 'uDmDatabase.pas' {dmDatabase: TDataModule},
  DmdDatabase_NFeBD in 'DmdDatabase_NFeBD.pas' {dmDatabase_NFeBD: TDataModule},
  UScriptAvulso in 'UScriptAvulso.pas' {frmScriptAvulso};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'SSPainelControle';
  Application.CreateForm(TdmDatabase, dmDatabase);
  Application.CreateForm(TdmDatabase_NFeBD, dmDatabase_NFeBD);
  Application.CreateForm(TfMenu, fMenu);
  Application.Run;
end.
