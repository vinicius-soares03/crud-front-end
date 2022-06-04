class Usuario {
  int? ID;
  String? NOME;
  String? SOBRENOME;
  String? EMAIL;
  String? ENDERECO;
  String? UF;
  String? CIDADE;
  String? CEP;
  String? CPF;

  Usuario({
    this.ID,
    this.NOME,
    this.SOBRENOME,
    this.EMAIL,
    this.ENDERECO,
    this.UF,
    this.CIDADE,
    this.CEP,
    this.CPF,
  });

  static Usuario fromJson(Map<String, dynamic> json) {
    return new Usuario(
      ID: json["id"],
      NOME: json["Nome"],
      SOBRENOME: json["Sobrenome"],
      EMAIL: json["Email"],
      ENDERECO: json["Endereco"],
      UF: json["UF"],
      CIDADE: json["Cidade"],
      CEP: json["Cep"],
      CPF: json["CPF"],
    );
  }

  Map toMap() {
    return {
      "data": {
        "Nome": this.NOME,
        "Sobrenome": this.SOBRENOME,
        "Email": this.EMAIL,
        "Endereco": this.ENDERECO,
        "UF": this.UF,
        "Cidade": this.CIDADE,
        "Cep": this.CEP,
        "CPF": this.CPF,
      }
    };
  }
}
