object dmDatabase: TdmDatabase
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 364
  Top = 153
  Height = 408
  Width = 528
  object scoDados: TSQLConnection
    ConnectionName = 'SSFacil'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    KeepConnection = False
    LibraryName = 'dbexpint.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      
        'Database=localhost:D:\Fontes\$Servisoft\Bases\SSFacil\SSFACIL.fd' +
        'b'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet=WIN1252'
      'SQLDialect=3'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'gds32.dll'
    Left = 41
    Top = 21
  end
  object Decoder64: TIdDecoderMIME
    FillChar = '='
    Left = 104
    Top = 21
  end
  object Encoder64: TIdEncoderMIME
    FillChar = '='
    Left = 168
    Top = 21
  end
  object sdsExec: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = scoDados
    Left = 280
    Top = 80
  end
  object scoAtualiza: TSQLConnection
    ConnectionName = 'FDBUpdate'
    DriverName = 'Interbase'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    KeepConnection = False
    LibraryName = 'dbexpint.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Interbase'
      'Database=firebird09-farm51.kinghost.net:/firebird/servisoft1.gdb'
      'RoleName=RoleName'
      'User_Name=servisoft1'
      'Password=campobom'
      'ServerCharSet='
      'SQLDialect=3'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'Interbase TransIsolation=ReadCommited'
      'Trim Char=False')
    VendorLib = 'gds32.dll'
    Connected = True
    Left = 42
    Top = 80
  end
  object sqVersaoAtual: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT VERSAO_BANCO FROM PARAMETROS')
    SQLConnection = scoDados
    Left = 236
    Top = 85
    object sqVersaoAtualVERSAO_BANCO: TIntegerField
      FieldName = 'VERSAO_BANCO'
    end
  end
  object sdsVersao: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT ID, SCRIPT '#13#10'FROM VERSAO'#13#10'WHERE IMPLANTADA = '#39'S'#39
    MaxBlobSize = -1
    Params = <>
    SQLConnection = scoAtualiza
    Left = 104
    Top = 80
    object sdsVersaoID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object sdsVersaoSCRIPT: TBlobField
      FieldName = 'SCRIPT'
      Size = 1
    end
  end
  object dspVersao: TDataSetProvider
    DataSet = sdsVersao
    Left = 144
    Top = 80
  end
  object cdsVersao: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ID'
    Params = <>
    ProviderName = 'dspVersao'
    Left = 185
    Top = 80
    object cdsVersaoID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsVersaoSCRIPT: TBlobField
      FieldName = 'SCRIPT'
      Size = 1
    end
  end
  object qMax: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT MAX(ID) ID'
      'FROM VERSAO'
      'WHERE IMPLANTADA = '#39'S'#39)
    SQLConnection = scoAtualiza
    Left = 168
    Top = 149
    object qMaxID: TIntegerField
      FieldName = 'ID'
    end
  end
end
