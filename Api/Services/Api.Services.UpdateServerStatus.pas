unit Api.Services.UpdateServerStatus;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.Threading, REST.Client;

type
  {$SCOPEDENUMS ON}
  TEnumCepServers = (viaCepServer, awesomeServer, apiCepServer);

  TUpdateServerStatus = class
  private class var
    FApiCepOnline     : Boolean;
    FAwesomeApiOnline : Boolean;
    FViaCepOnline     : Boolean;

  private
    class function RequestCepStatus(AEndPoint: string): Boolean;
    class function ServerViaCepOnline : Boolean;
    class function ServerApiCepOnline : Boolean;
    class function ServerAwesomeApiOnline : Boolean;
  public
    class property ApiCepOnline     : Boolean read FApiCepOnline;
    class property AwesomeApiOnline : Boolean read FAwesomeApiOnline;
    class property ViaCepOnline     : Boolean read FViaCepOnline;

    class procedure UpdateServerStatus;
    class function RequestCep(AEndPoint: string): TJSonObject;
  end;

implementation

uses
  Api.Services.Utils;

{ TUpdateServerStatus }

class function TUpdateServerStatus.ServerViaCepOnline : Boolean;
begin
  Result := RequestCepStatus('viacep.com.br/ws/01001000/json/');
end;

class function TUpdateServerStatus.ServerApiCepOnline : Boolean;
begin
  Result := RequestCepStatus('https://ws.apicep.com/cep/01001000.json');
end;

class function TUpdateServerStatus.ServerAwesomeApiOnline : Boolean;
begin
  Result := RequestCepStatus('https://cep.awesomeapi.com.br/json/01001000');
end;

class function TUpdateServerStatus.RequestCepStatus(AEndPoint : string): Boolean;
var
  LRequest : TRESTRequest;
begin
  Result := False;
  LRequest := TUtils.CriarRequest(AEndPoint);
  try
    try
      LRequest.Execute;
      if LRequest.Response.StatusCode = 200 then
        Result := True;
    except on E: Exception do
      Writeln(E.Message);
    end;
  finally
    LRequest.Free;
  end;
end;

class function TUpdateServerStatus.RequestCep(AEndPoint: string): TJSonObject;
var
  LRequest : TRESTRequest;
  LJSonValue : TJsonValue;
begin
  Writeln(DateTimeToStr(Now)+' - Requisição do client: '+AEndPoint);
  LRequest := TUtils.CriarRequest(AEndPoint);
  try
    try
      LRequest.Execute;
      if LRequest.Response.StatusCode = 200 then
      begin
        LJSonValue := TJSONObject.ParseJsonValue(LRequest.Response.Content);
        Result := LJSonValue as TJSonObject;
      end;
    except on E: Exception do
      raise;
    end;
  finally
    LRequest.Free;
  end;
end;

class procedure TUpdateServerStatus.UpdateServerStatus;
begin
  FViaCepOnline     := ServerViaCepOnline;
  FApiCepOnline     := ServerApiCepOnline;
  FAwesomeApiOnline := ServerAwesomeApiOnline;
end;

end.
