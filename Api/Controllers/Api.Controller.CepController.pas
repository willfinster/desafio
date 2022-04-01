unit Api.Controller.CepController;

interface

uses
  System.JSON,
  Horse,
  Horse.GBSwagger,
  Horse.GBSwagger.Helpers,
  Api.Models.Cep,
  GBSwagger.Path.Attributes;

type
  [SwagPath('cep','CEP')]
  TCepController = class(THorseGBSwagger)
  public
    [SwagGET('/{cep}','Busca CEP',True,'Busca o CEP')]
    [SwagParamPath('cep','CEP - Cep que será consultado.')]
    [SwagResponse(200,TCep,False)]
    [SwagResponse(400)]
    procedure GetCep;
  end;

implementation

uses
  Api.Services.UpdateServerStatus;

{ TCepController }

procedure TCepController.GetCep;
var
  LCep : string;
begin
  LCep := '';
  if FRequest.Params.ContainsKey('cep') then
    LCep := FRequest.Params['cep'];

  if Length(LCep) <> 8 then
    FResponse.Status(THTTPStatus.BadRequest).Send('Parâmetro CEP incorreto!');

  if TUpdateServerStatus.ViaCepOnline then
    BuscarCep(LCep,TEnumCepServers.viaCepServer);


  FResponse.Send('Consultou');
end;

function BuscarCep(ACep: string;AServer: TEnumCepServers): TCep;
var
  LJSonObject : TJSonObject;
begin
  case AServer of
    TEnumCepServers.viaCepServer:
    begin
      LJSonObject := TUpdateServerStatus.RequestCep('https://ws.apicep.com/cep/'+ACep+'.json');
      Result := TCep.ConvertToObjectCep(LJSonObject);
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

initialization
  THorseGBSwaggerRegister.RegisterPath(TCepController);

end.
