program Desafio_API;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.GBSwagger,
  Api.Controllers.SwagController in 'Api\Controllers\Api.Controllers.SwagController.pas',
  Api.Models.Cep in 'Api\Models\Api.Models.Cep.pas',
  Api.Controller.CepController in 'Api\Controllers\Api.Controller.CepController.pas',
  Api.Services.Utils in 'Api\Services\Api.Services.Utils.pas',
  Api.Services.ServerCep in 'Api\Services\Api.Services.ServerCep.pas',
  Api.Services.UpdateServerStatus in 'Api\Services\Api.Services.UpdateServerStatus.pas';

begin
  THorse.Use(HorseSwagger);

  TCepThread.StartServicesVerification;

  THorse.Listen(9000);
end.
