program Desafio_API;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.GBSwagger,
  Horse.Jhonson,
  Horse.HandleException,
  Api.Controllers.Swag in 'Api\Controllers\Api.Controllers.Swag.pas',
  Api.Models.Cep in 'Api\Models\Api.Models.Cep.pas',
  Api.Controller.Cep in 'Api\Controllers\Api.Controller.Cep.pas',
  Api.Services.Utils in 'Api\Services\Api.Services.Utils.pas',
  Api.Services.ServerCep in 'Api\Services\Api.Services.ServerCep.pas',
  Api.Services.UpdateServerStatus in 'Api\Services\Api.Services.UpdateServerStatus.pas';

begin
  THorse
    .Use(HorseSwagger)
    .Use(Jhonson)
    .Use(HandleException);

  THorse.Listen(9000);
end.
