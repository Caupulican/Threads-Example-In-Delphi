program ThreadsExample;

uses
  Vcl.Forms,
  uThreadsExample in 'uThreadsExample.pas' {FrmThreads};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmThreads, FrmThreads);
  Application.Run;
end.
