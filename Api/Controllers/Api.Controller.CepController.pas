unit Api.Controller.CepController;

interface

uses
  System.JSON,
  Horse,
  Horse.GBSwagger,
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
    TCep.BuscarCep(LCep,TEnumCepServers.viaCepServer);


  FResponse.Send('Consultou');
end;

initialization
  THorseGBSwaggerRegister.RegisterPath(TCepController);

end.
