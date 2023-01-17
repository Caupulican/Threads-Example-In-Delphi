unit uThreadsExample;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  System.Threading,
  System.IOUtils,
  System.Math,
  System.Generics.Collections;

type
  Tarq2 = record
    numero:cardinal;
    datahora: TDateTime;
    quant: integer;
    preco:  Currency;
    comprador:integer;
    vendedor:integer;
  end;

  TFrmThreads = class(TForm)
    Button1 : TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender : TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    function Soma(a, b : integer) : integer;
    procedure ShowSoma;
    procedure ShowSoma2;
  end;

var
  FrmThreads : TFrmThreads;
  histfr : TList<TArq2>;

implementation

{$R *.dfm}


procedure TFrmThreads.Button1Click(Sender : TObject);
var
  vTask : iTask;
begin
  vTask := TTask.Create(ShowSoma);
  vTask.Start;
end;

procedure TFrmThreads.Button2Click(Sender: TObject);
var
  vThreadArray : array[0..1] of iTask;
  I: Integer;
  Inicio: TDateTime;
  Fim: TDateTime;
begin
  Inicio := Now;
  vThreadArray[0] := TTask.Create(ShowSoma);
  vThreadArray[0].Start;
  vThreadArray[1] := TTask.Create(ShowSoma2);
  vThreadArray[1].Start;
  //Forma um semáforo
  TTask.WaitForAll(vThreadArray);
  Fim := Now;
  ShowMessage(Format('Consultas realizadas em %s segundos.',
    [FormatDateTime('ss', Fim - Inicio)]));
end;

procedure TFrmThreads.Button3Click(Sender: TObject);
begin
  //Para ser usado com uma listagem, thread semáforo
  TParallel.For(0, 3 {Pred(ListaArquivos.Count)},
  procedure (i: integer)
  begin
    TThread.Queue(TThread.CurrentThread,
      procedure
      begin
        //Exemplo método a ser processado
        ShowMessage(i.ToString);
       { FazAlgumaCoisa(ListaArquivos[i]); }
      end)
  end);
end;

procedure TFrmThreads.Button4Click(Sender: TObject);
var
  vLinha : string;
  vHora : TDateTime;
  I: Integer;
  vDiretorio : TArray<string>;
  vMedia : array of Tarq2;
  FileHandle: File of Tarq2;
  vIndex : integer;
  vNome : string;
  vStream : TStream;
  vMediaObjeto : Tarq2;
  BlockSize : Integer;
  BytesToRead: Integer;
begin
  vDiretorio := TDirectory.GetFiles('myfiles');
  ShowMessage(IntToStr(Length(vDiretorio)));
  vhora := Now;
  vIndex := 0;
  BlockSize := 1000000;
  histfr := TList<TArq2>.Create;
  for vIndex := 0 to High(vDiretorio) do
  begin
    vNome := vDiretorio[vIndex];
    vStream := TFileStream.Create(vNome, fmOpenRead);
    try
      while vStream.Position < vStream.Size do
      begin
        BytesToRead := Min(BlockSize * SizeOf(Tarq2), vStream.Size - vStream.Position);
        SetLength(vMedia, BytesToRead div SizeOf(Tarq2));
        vStream.ReadBuffer(vMedia[0], BytesToRead);
        for vMediaObjeto in vMedia do
          histfr.Add(vMediaObjeto);
      end;
    finally
      vStream.Free;
    end;
  end;
end;

procedure TFrmThreads.ShowSoma;
begin
  //Delay para mostrar o funcionamento alternado de cada thread
  sleep(2000);
end;

procedure TFrmThreads.ShowSoma2;
begin
  sleep(4000);
end;

function TFrmThreads.Soma(a, b: integer): integer;
begin
  Result := a+b;
end;

end.
