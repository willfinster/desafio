unit Api.Controllers.SwagController;

interface

type
  TSwagController = class
    public
      class procedure IniciarDocumentacao;
  end;

implementation

uses
  Horse,
  Horse.GBSwagger;

{ TSwagController }

class procedure TSwagController.IniciarDocumentacao;
begin
  Swagger
    .Info
      .Title('Desafio')
      .Description('Terceira etapa da seleção para a vaga Delphi / Horse')
      .Contact
        .Name('William Finsterbusch')
        .Email('will_finster@hotmail.com')
      .&end
    .&end;
end;

end.
