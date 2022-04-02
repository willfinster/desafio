unit Api.Services.Utils;

interface

uses
  System.Classes,
  System.SysUtils,
  REST.Client,
  REST.Types;

type
  TUtils = record
    public
      class function CriarRequest(AEndPoint : string): TRESTRequest; static;
      class function TiraMascara(ACep : string): string; static;
  end;

implementation

{ TUtils }

class function TUtils.CriarRequest(AEndPoint: string): TRESTRequest;
var
  LRequest : TRESTRequest;
begin
  LRequest          := TRESTRequest.Create(nil);
  LRequest.Client   := TRESTClient.Create(LRequest);
  LRequest.Response := TRESTResponse.Create(LRequest);
  try
    try
      LRequest.Client.Accept              := 'application/json';
      LRequest.Client.AcceptCharset       := 'UTF-8, *;q=0.8';
      LRequest.Client.HandleRedirects     := True;
      LRequest.Client.RaiseExceptionOn500 := False;
      LRequest.Timeout                    := 10000;
      LRequest.Client.BaseURL             := AEndPoint;
      LRequest.SynchronizedEvents         := False;   //V 10.2 valor default False
                                                      //V 10.4 valor default True
    except
      on E: Exception do
      begin
        Writeln(E.Message);
        raise;
      end;
    end;
  finally
    Result := LRequest;
  end;
end;

class function TUtils.TiraMascara(ACep: string): string;
var
  LCont : Integer;
begin
  LCont := Length(ACep);
  while LCont > 0 do
  begin
    if not(ACep[LCont] IN ['0'..'9']) then
      Delete(ACep,LCont,1);
    Dec(LCont);
  end;
  Result := ACep;
end;

end.
