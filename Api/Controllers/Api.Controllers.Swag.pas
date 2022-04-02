unit Api.Controllers.Swag;

interface

type
  TSwagController = class
    public
      class procedure IniciarDocumentacao;
  end;

implementation

uses
  Horse,
  Horse.GBSwagger, Api.Services.Utils;

{ TSwagController }

class procedure TSwagController.IniciarDocumentacao;
begin
  Swagger
    .Info
      .Title('Desafio')
      .Description('Descri��o do desafio')
      .Contact
        .Name('William Finsterbusch')
        .Email('will_finster@hotmail.com')
      .&end
    .&end;


    Writeln('Para consultar a documenta��o, acesse: http://localhost:9000/swagger/doc/html');
end;

initialization
  TSwagController.IniciarDocumentacao;

end.
