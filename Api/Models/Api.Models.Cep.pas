unit Api.Models.Cep;

interface

uses
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
      class function ConvertToObjectCep(AObject : TJSonObject; AServer : TEnumCepServers): TCep;
      class function BuscarCep(ACep: string;AServer: TEnumCepServers): TCep;
  end;

  TViaCepStruct = class
    cep         : string;
    logradouro  : string;
    complemento : string;
    bairro      : string;
    localidade  : string;
    uf          : string;
    ibge        : string;
    gia         : string;
    ddd         : string;
    siafi       : string;
  end;

  TAwesomeApiStruct = class
    cep          : string;
    address_type : string;
    address_name : string;
    address      : string;
    district     : string;
    state        : string;
    city         : string;
    lat          : string;
    lng          : string;
    ddd          : string;
    city_ibge    : string;
  end;

  TApiCepStruct = class
    status       : string;
    code         : string;
    state        : string;
    city         : string;
    district     : string;
    address      : string;
  end;

implementation

{ TCep }

class function TCep.BuscarCep(ACep: string; AServer: TEnumCepServers): TCep;
var
  LJSonObject : TJSonObject;
begin
  case AServer of
    TEnumCepServers.viaCepServer:
    begin
      LJSonObject := TUpdateServerStatus.RequestCep('https://ws.apicep.com/cep/'+ACep+'.json');
      Result := TCep.ConvertToObjectCep(LJSonObject,AServer);
    end;
    TEnumCepServers.awesomeServer:
    begin
      TUpdateServerStatus.RequestCep('https://cep.awesomeapi.com.br/json/');
    end;
    TEnumCepServers.apiCepServer:
    begin
      TUpdateServerStatus.RequestCep('viacep.com.br/ws/'+ACep+'/json/');
    end;
  end;
end;

class function TCep.ConvertToObjectCep(AObject: TJSonObject ; AServer : TEnumCepServers): TCep;
var
  LViaCep     : TViaCepStruct;
  LAwesomeApi : TAwesomeApiStruct;
  LApiCep     : TApiCepStruct;
  LCep        : TCep;
begin
  case AServer of
    TEnumCepServers.viaCepServer:
    begin
      LViaCep := TJson.JSonToObject<TViaCepStruct>(AObject);
      try
        LCep.cep      := LViaCep.cep;
        LCep.endereco := LViaCep.logradouro;
        LCep.bairro   := LViaCep.bairro;
        LCep.cidade   := LViaCep.localidade;
        LCep.uf       := LViaCep.uf;
        Result := LCep;
      finally
        LViaCep.Free;
        LCep.Free;
      end;
    end;
    TEnumCepServers.awesomeServer:
    begin
      LAwesomeApi := TJson.JSonToObject<TAwesomeApiStruct>(AObject);
      try
        LCep.cep      := LAwesomeApi.cep;
        LCep.endereco := LAwesomeApi.address;
        LCep.bairro   := LAwesomeApi.district;
        LCep.cidade   := LAwesomeApi.city;
        LCep.uf       := LAwesomeApi.state;
        Result := LCep;
      finally
        LAwesomeApi.Free;
        LCep.Free;
      end;
    end;
    TEnumCepServers.apiCepServer:
    begin
      LApiCep := TJson.JSonToObject<TApiCepStruct>(AObject);
      try
        LCep.cep      := LApiCep.code;
        LCep.endereco := LApiCep.address;
        LCep.bairro   := LApiCep.district;
        LCep.cidade   := LApiCep.city;
        LCep.uf       := LApiCep.state;
        Result := LCep;
      finally
        LApiCep.Free;
        LCep.Free;
      end;
    end;
  end;
end;

end.
