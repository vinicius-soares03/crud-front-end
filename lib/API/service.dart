import 'dart:convert';

import 'package:crud_web/crud-usuario/model/usuario-viewmodel.dart';
import 'package:http/http.dart' as http;

class Service {
  String url = 'https://api-crud-web.herokuapp.com/api/usuarios';

  Future<List<Usuario>?> buscarTodosUsuarios() async {
    try {
      String _url = "$url";

      var request = await http.get(Uri.parse(_url));

      Map<String, dynamic> map = jsonDecode(request.body);
      List<dynamic> lista = map["data"];
      List<Usuario>? listaUsuarios = [];
      lista.forEach((element) {
        listaUsuarios.addAll({
          Usuario(
              ID: element["id"],
              NOME: Usuario.fromJson(element["attributes"]).NOME,
              SOBRENOME: Usuario.fromJson(element["attributes"]).SOBRENOME,
              EMAIL: Usuario.fromJson(element["attributes"]).EMAIL,
              ENDERECO: Usuario.fromJson(element["attributes"]).ENDERECO,
              UF: Usuario.fromJson(element["attributes"]).UF,
              CIDADE: Usuario.fromJson(element["attributes"]).CIDADE,
              CEP: Usuario.fromJson(element["attributes"]).CEP,
              CPF: Usuario.fromJson(element["attributes"]).CPF)
        });
      });

      return listaUsuarios;
    } catch (e) {
      return null;
    }
  }

  Future<bool>? cadastrarUsuario(Usuario usuario) async {
    try {
      String _url = "$url";

      var request = await http.post(Uri.parse(_url),
          headers: {
            "content-type": "application/json",
          },
          body: json.encode(usuario.toMap()));

      return request.statusCode >= 200 && request.statusCode < 300;
    } catch (e) {
      return false;
    }
  }

  Future<bool>? alterarUsuario(Usuario usuario) async {
    try {
      String _url = "$url/${usuario.ID}";
      

      var request = await http.put(Uri.parse(_url),
          headers: {
            "content-type": "application/json",
          },
          body: json.encode(usuario.toMap()));

      return request.statusCode >= 200 && request.statusCode < 300;
    } catch (e) {
      return false;
    }
  }

  Future<bool>? deletarUsuario(int id) async {
    try {
      String _url = "$url/$id";

      var request = await http.delete(
        Uri.parse(_url),
        headers: {
          "content-type": "application/json",
        },
      );

      return request.statusCode >= 200 && request.statusCode < 300;
    } catch (e) {
      return false;
    }
  }
}
