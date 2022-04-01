unit Api.Models.Cep;

interface

type
  TCep = class
    private
      Fcep         : string;
      Flogradouro  : string;
      Fcomplemento : string;
      Fbairro      : string;
      Flocalidade  : string;
      Fuf          : string;
      Fibge        : string;
      Fgia         : string;
      Fddd         : string;
      Fsiafi       : string;

    public
      property cep          : string  read Fcep         write Fcep;
      property logradouro   : string  read Flogradouro  write Flogradouro;
      property complemento  : string  read Fcomplemento write Fcomplemento;
      property bairro       : string  read Fbairro      write Fbairro;
      property localidade   : string  read Flocalidade  write Flocalidade;
      property uf           : string  read Fuf          write Fuf;
      property ibge         : string  read Fibge        write Fibge;
      property gia          : string  read Fgia         write Fgia;
      property ddd          : string  read Fddd         write Fddd;
      property siafi        : string  read Fsiafi       write Fsiafi;
  end;

implementation

end.
