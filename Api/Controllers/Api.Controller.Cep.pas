unit Api.Controller.Cep;

interface

uses
  System.JSON,
  Horse,
  Horse.GBSwagger,
  Api.Models.Cep,
  GBSwagger.Path.Attributes,
  REST.Json;

type
  [SwagPath('cep','CEP')]
  TCepController = class(THorseGBSwagger)
  public
    [SwagGET('/{cep}','Busca CEP',True,'Busca o CEP')]
    [SwagParamPath('cep','CEP - Cep que será consultado.')]
    [SwagResponse(200,TCep,False)]
    [SwagResponse(400)]
    [SwagResponse(404)]
    [SwagREsponse(500)]
    procedure GetCep;
  end;

implementation

uses
  Api.Services.UpdateServerStatus, Api.Services.Utils;

{ TCepController }

procedure TCepController.GetCep;
var
  LCepString : string;
  LCep       : TJSonObject;
begin
  LCepString := '';
  if FRequest.Params.ContainsKey('cep') then
    LCepString := FRequest.Params['cep'];

  LCepString := TUtils.TiraMascara(LCepString);

  if Length(LCepString) <> 8 then
  begin
    FResponse.Status(400);
    Exit
  end;

  if TUpdateServerStatus.ViaCepOnline then
    LCep := TCep.BuscarCep(LCepString,TEnumCepServers.viaCepServer)
  else if TUpdateServerStatus.AwesomeApiOnline then
    LCep := TCep.BuscarCep(LCepString,TEnumCepServers.awesomeServer)
  else if TUpdateServerStatus.ApiCepOnline then
    LCep := TCep.BuscarCep(LCepString, TEnumCepServers.apiCepServer)
  else
  begin
    FResponse.Status(500);
    Exit;
  end;

  FResponse.Send(LCep.ToJSON);
end;

initialization
  THorseGBSwaggerRegister.RegisterPath(TCepController);

end.
