unit UFrmSettings;

interface

uses Vcl.Forms, Vcl.StdCtrls, System.Classes, Vcl.Controls;

type
  TFrmSettings = class(TForm)
    CkSounds: TCheckBox;
    BtnOK: TButton;
    BtnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnOKClick(Sender: TObject);
  end;

  TSettings = class
  private
    class function GetIniFile: String;
  public
    class procedure Load;
    class procedure Save;
  end;

var
  FrmSettings: TFrmSettings;

procedure ShowSettings;

implementation

{$R *.dfm}

uses UVars, System.IniFiles, System.SysUtils;

class function TSettings.GetIniFile: String;
begin
  Result := ExtractFilePath(Application.ExeName)+'Scrabble.ini';
end;

class procedure TSettings.Load;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(GetIniFile);
  try
    pubEnableSounds := Ini.ReadBool('Global', 'Sounds', True);
  finally
    Ini.Free;
  end;
end;

class procedure TSettings.Save;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(GetIniFile);
  try
    Ini.WriteBool('Global', 'Sounds', pubEnableSounds);
  finally
    Ini.Free;
  end;
end;

//

procedure ShowSettings;
begin
  FrmSettings := TFrmSettings.Create(Application);
  FrmSettings.ShowModal;
  FrmSettings.Free;
end;

//

procedure TFrmSettings.FormCreate(Sender: TObject);
begin
  CkSounds.Checked := pubEnableSounds;
end;

procedure TFrmSettings.BtnOKClick(Sender: TObject);
begin
  pubEnableSounds := CkSounds.Checked;

  TSettings.Save;

  ModalResult := mrOk;
end;

end.