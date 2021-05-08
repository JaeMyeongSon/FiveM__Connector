unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,SHDocVw, Vcl.Imaging.pngimage,TlHelp32,
  Vcl.ExtCtrls, Vcl.OleCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    WebBrowser1: TWebBrowser;
    Timer1: TTimer;
    Label2: TLabel;
    Button1: TButton;
    Timer2: TTimer;
    WebBrowser2: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
    check:integer;
implementation

{$R *.dfm}

function processExists(exeFileName: string): Boolean; //프로세스 
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False;
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then
    begin
      Result := True;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
Label1.Visible := false;
Label2.Visible := true;
timer2.Enabled :=true;
timer1.Enabled := false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   Borderstyle := bsNone;
WebBrowser1.Silent :=True;
WebBrowser2.Navigate('https://www.jango.com/stations/361346219/tunein'); // 음악 
end;


procedure TForm1.Label1Click(Sender: TObject);
begin
WebBrowser1.Navigate('fivem://connect/13.125.110.124:30120'); //접속
Label1.Caption := 'FiveM 실행중..' ; 
 Timer1.Enabled := true;
 WebBrowser2.OleObject.Document.Body.Scroll:='no';
//ShowMessage ('오늘도 오산서버를 플레이 해주셔서 감사합니다')
end;


procedure TForm1.Timer1Timer(Sender: TObject); //프로세스 
 begin
  if processExists('FiveM.exe') then
       Button1.Click
  // Label1.Caption :='서버에 접속 되었습니다'+#13#10+' 10초후'+#13#10+ '런처가 자동으로 종료됩니다.'
  else
   WebBrowser1.Navigate('fivem://connect/13.125.110.124:30120');

 end;


procedure TForm1.Timer2Timer(Sender: TObject);
begin
if HiWord(GetKeyState(VK_END)) <> 0 then
  Application.Terminate;
end;

end.
