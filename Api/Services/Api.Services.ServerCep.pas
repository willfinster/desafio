unit Api.Services.ServerCep;

interface

uses
  System.SysUtils;

type
  TCepThread = record
    public
      class procedure StartServicesVerification; static;
  end;

implementation

{ TCepThread }

class procedure TCepThread.StartServicesVerification;
var
  LSleepCount : Integer;
begin
  while True do
  begin
    try

      //Todo: Implementar verifica��o de server 1 e retornar para uma vari�vel global
      //Todo: Implementar verifica��o de server 2 e retornar para var global
      //Todo: Implementar verifica��o de server 3 e retornar para var global.



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
end;

end.
