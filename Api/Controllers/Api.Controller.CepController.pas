unit Api.Controller.CepController;

interface

uses
  Horse,
  Horse.GBSwagger,
  Api.Models.Cep,
  GBSwagger.Path.Attributes;

type
  [SwagPath('CEP','CEP')]
  TCepController = class(THorseGBSwagger)
  public
    {$REGION 'Doc GetCEP'}
    [SwagGET('Busca CEP',True,'Busca o CEP')]
    [SwagParamPath('cep','CEP - Cep que será consultado.')]
    [SwagResponse(200,TCep,False)]
    {$ENDREGION}
    procedure GetCep;
  end;

implementation

{ TCepController }

procedure TCepController.GetCep;
begin
  FResponse.Send('Pong');
end;

initialization
  THorseGBSwaggerRegister.RegisterPath(TCepController);

end.
