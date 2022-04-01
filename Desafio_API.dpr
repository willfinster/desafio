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
  Api.Services.ServerCep in 'Api\Services\Api.Services.ServerCep.pas';

begin
  TSwagController.IniciarDocumentacao;

  THorse.Use(HorseSwagger);

//  THorse.Get('/ping',
//    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
//    begin
//      Res.Send('pong');
//    end);

  TCepThread.StartServicesVerification;

  THorse.Listen(9000);
end.
