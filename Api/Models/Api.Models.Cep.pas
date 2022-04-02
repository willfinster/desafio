unit Api.Models.Cep;

interface

uses
  System.SysUtils,
  System.JSON,
  REST.Json,

  Api.Services.UpdateServerStatus;

type
  TCep = class
    private
      Fcep         : string;
      Fendereco    : string;
      Fbairro      : string;
      Fcidade      : string;
      Fuf          : string;

    public
      property cep          : string  read Fcep         write Fcep;
      property endereco     : string  read Fendereco    write Fendereco;
      property bairro       : string  read Fbairro      write Fbairro;
      property cidade       : string  read Fcidade      write Fcidade;
      property uf           : string  read Fuf          write Fuf;

    public
      class function ConvertToObjectCep(AObject : TJSonObject; AServer : TEnumCepServers): TJSonObject;
      class function BuscarCep(ACep: string;AServer: TEnumCepServers): TJSonObject;
  end;

implementation

{ TCep }

class function TCep.BuscarCep(ACep: string; AServer: TEnumCepServers): TJSonObject;
var
  LJSonObject : TJSonObject;
begin
  try
    case AServer of
      TEnumCepServers.viaCepServer:  LJSonObject := TUpdateServerStatus.RequestCep('viacep.com.br/ws/'+ACep+'/json/');
      TEnumCepServers.awesomeServer: LJSonObject := TUpdateServerStatus.RequestCep('https://cep.awesomeapi.com.br/json/'+ACep);
      TEnumCepServers.apiCepServer:  LJSonObject := TUpdateServerStatus.RequestCep('https://ws.apicep.com/cep/'+ACep+'.json');
    end;
    LJSonObject := ConvertToObjectCep(LJSonObject,AServer);
    Result := LJSonObject;
  except on E: Exception do
    raise;
  end;
end;

class function TCep.ConvertToObjectCep(AObject: TJSonObject ; AServer : TEnumCepServers): TJSonObject;
var
  LCep : TCep;
begin
  LCep := TCep.Create;
  try
    try
      case AServer of
        TEnumCepServers.viaCepServer:
        begin
          LCep.cep      := AObject.GetValue<string>('cep');
          LCep.endereco := AObject.GetValue<string>('logradouro');
          LCep.bairro   := AObject.GetValue<string>('bairro');
          LCep.cidade   := AObject.GetValue<string>('localidade');
          LCep.uf       := AObject.GetValue<string>('uf');
        end;
        TEnumCepServers.awesomeServer:
        begin
          LCep.cep      := AObject.GetValue<string>('cep');
          LCep.endereco := AObject.GetValue<string>('address');
          LCep.bairro   := AObject.GetValue<string>('district');
          LCep.cidade   := AObject.GetValue<string>('city');
          LCep.uf       := AObject.GetValue<string>('state');
        end;
        TEnumCepServers.apiCepServer:
        begin
          LCep.cep      := AObject.GetValue<string>('code');
          LCep.endereco := AObject.GetValue<string>('address');
          LCep.bairro   := AObject.GetValue<string>('district');
          LCep.cidade   := AObject.GetValue<string>('city');
          LCep.uf       := AObject.GetValue<string>('state');
        end;
      end;
      Result := TJson.ObjectToJsonObject(LCep);
    except on E: Exception do
      raise;
    end;
  finally
    LCep.Free;
  end;
end;

end.
