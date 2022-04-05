unit Api.Services.ServerCep;

interface

uses
  Horse,
  System.SysUtils,
  System.Classes,
  System.Threading;

type
  TCepService = class
    public
      class procedure StartServicesVerification; static;
  end;

implementation

uses
  Api.Services.UpdateServerStatus, Api.Services.Utils;

{ TCepThread }

class procedure TCepService.StartServicesVerification;
var
  LSleepCount : Integer;
  LTask       : ITask;
begin
  LTask := TTask.Create(
  procedure
  begin
    Writeln(DateTimeToStr(Now)+' - Iniciado serviço...');
    while True do
    begin
      try
        Writeln(DateTimeToStr(Now)+' - Consultando Status nos servidores...');
        TUpdateServerStatus.UpdateServerStatus;

        LSleepCount := 10000;
        while (LSleepCount > 0) do
        begin
          Dec(LSleepCount,100);
          Sleep(100);
        end;
      except on E: Exception do
        Writeln(DateTimeToStr(Now)+' - '+E.Message);
      end;
    end;
  end);
  LTask.Start;
end;

initialization
  TCepService.StartServicesVerification;

end.
