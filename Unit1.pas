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

function processExists(exeFileName: string): Boolean;
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
//WebBrowser1.OleObject.Document.Body.Scroll:='no';
   Borderstyle := bsNone;
WebBrowser1.Silent :=True;
//SetWindowPos(Form1.handle, HWND_TOPMOST, Form1.Left, Form1.Top, Form1.Width, Form1.Height,0);
WebBrowser2.Navigate('https://www.jango.com/stations/361346219/tunein');
end;


procedure TForm1.Label1Click(Sender: TObject);
begin
WebBrowser1.Navigate('fivem://connect/13.125.110.124:30120');
Label1.Caption := 'FiveM ������..' ;
 Timer1.Enabled := true;
 WebBrowser2.OleObject.Document.Body.Scroll:='no';
//ShowMessage ('���õ� ���꼭���� �÷��� ���ּż� �����մϴ�')
end;


procedure TForm1.Timer1Timer(Sender: TObject);
 begin
  if processExists('FiveM.exe') then
       Button1.Click
  // Label1.Caption :='������ ���� �Ǿ����ϴ�'+#13#10+' 10����'+#13#10+ '��ó�� �ڵ����� ����˴ϴ�.'
  else
   WebBrowser1.Navigate('fivem://connect/13.125.110.124:30120');

 end;


procedure TForm1.Timer2Timer(Sender: TObject);
begin
if HiWord(GetKeyState(VK_END)) <> 0 then
  Application.Terminate;
end;

end.
