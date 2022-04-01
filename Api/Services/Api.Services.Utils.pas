unit Api.Services.Utils;

interface

uses
  System.SysUtils,
  IPPeerClient,
  REST.Client;

type
  TUtils = record
    public
      class function CriarRequest(AEndPoint : string): TRESTRequest; static;
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
      LRequest.Client.Accept := 'application/json';
      LRequest.Client.AcceptCharset   := 'UTF-8, *;q=0.8';
      LRequest.Client.HandleRedirects := True;
      LRequest.Timeout                := 10000;
      LRequest.Client.BaseURL         := AEndPoint;
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

end.
