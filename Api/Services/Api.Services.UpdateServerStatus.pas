unit Api.Services.UpdateServerStatus;

interface

uses
  System.SysUtils,
  System.JSON,

  REST.Json,
  REST.Client;

  //Api.Models.Cep;

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
    class procedure ServerViaCepOnline;
    class procedure ServerApiCepOnline;
    class procedure ServerAwesomeApiOnline;
  public
    class property ApiCepOnline     : Boolean read FApiCepOnline;
    class property AwesomeApiOnline : Boolean read FAwesomeApiOnline;
    class property ViaCepOnline     : Boolean read FViaCepOnline;

    class procedure UpdateServerStatus;
    class function RequestCep(AEndPoint: string): TJSonObject; overload;
  end;

implementation

uses
  Api.Services.Utils;

{ TUpdateServerStatus }

class procedure TUpdateServerStatus.ServerApiCepOnline;
begin
  FApiCepOnline := RequestCepStatus('https://ws.apicep.com/cep/01001000.json');
  if FApiCepOnline then
    Writeln('ApiCep: Online')
  else
    Writeln('ApiCep: Offline')
end;

class procedure TUpdateServerStatus.ServerAwesomeApiOnline;
begin
  FAwesomeApiOnline := RequestCepStatus('https://cep.awesomeapi.com.br/json/01001000');
  if FAwesomeApiOnline then
    Writeln('Awesome Api: Online')
  else
    Writeln('Awesome Api: Offline')
end;

class procedure TUpdateServerStatus.ServerViaCepOnline;
begin
  FViaCepOnline := RequestCepStatus('viacep.com.br/ws/01001000/json/');
  if FViaCepOnline then
    Writeln('ViaCep: Online')
  else
    Writeln('ViaCep: Offline')
end;

class function TUpdateServerStatus.RequestCepStatus(AEndPoint : string): Boolean;
var
  LRequest : TRESTRequest;
begin
  Result := False;
  Writeln('Consultando Status server: '+AEndPoint);
  LRequest := TUtils.CriarRequest(AEndPoint);
  try
    try
      LRequest.Execute;
      if LRequest.Response.StatusCode = 200 then
        Result := True;
    except on E: Exception do
      raise;
    end;
  finally
    LRequest.Free;
  end;
end;

class function TUpdateServerStatus.RequestCep(AEndPoint: string): TJSonObject;
var
  LRequest : TRESTRequest;
begin
  Writeln('Requisição do client: '+AEndPoint);
  LRequest := TUtils.CriarRequest(AEndPoint);
  try
    try
      LRequest.Execute;
      if LRequest.Response.StatusCode = 200 then
        Result := TJSONObject.ParseJsonValue(LRequest.Response.Content) as TJSONObject;
    except on E: Exception do
      raise;
    end;
  finally
    LRequest.Free;
  end;
end;

class procedure TUpdateServerStatus.UpdateServerStatus;
begin
  ServerViaCepOnline;
  ServerApiCepOnline;
  ServerAwesomeApiOnline;
end;

end.
