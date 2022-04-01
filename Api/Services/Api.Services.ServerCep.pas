unit Api.Services.ServerCep;

interface

uses
  System.SysUtils,
  System.Threading;

type
  TCepThread = record
    public
      class procedure StartServicesVerification; static;
  end;

implementation

uses
  Api.Services.UpdateServerStatus;

{ TCepThread }

class procedure TCepThread.StartServicesVerification;
var
  LSleepCount : Integer;
  LTask       : ITask;
begin
  LTask := TTask.Create(
  procedure
  begin
    WriteLn('Iniciado serviço...');
    while True do
    begin
      try
        TUpdateServerStatus.UpdateServerStatus;

        LSleepCount := 10000;
        while (LSleepCount > 0) do
        begin
          Dec(LSleepCount,100);
          Sleep(100);
        end;
      except
        ReleaseExceptionObject;
      end;
    end;
  end);
  LTask.Start;
end;

end.
