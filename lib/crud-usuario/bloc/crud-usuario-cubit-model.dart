import 'package:crud_web/crud-usuario/model/usuario-viewmodel.dart';

class CrudUsuarioModel {
  String? exemplo;
  List<Usuario>? listaUsuarios;
  String? ufDropdownValue;
  String? cidadeDropdownValue;
  String? usuarioSelecionadoCidade;
  String? usuarioSelecionadoUF;

  CrudUsuarioModel(
      {this.exemplo,
      this.listaUsuarios,
      this.ufDropdownValue,
      this.cidadeDropdownValue,
      this.usuarioSelecionadoCidade,
      this.usuarioSelecionadoUF
      });

  CrudUsuarioModel patchState({
    String? exemplo,
    List<Usuario>? listaUsuarios,
    String? ufDropdownValue,
    String? cidadeDropdownValue,
    String? usuarioSelecionadoCidade,
  String? usuarioSelecionadoUF,
  }) {
    return new CrudUsuarioModel(
        exemplo: exemplo ?? this.exemplo,
        listaUsuarios: listaUsuarios ?? this.listaUsuarios,
        ufDropdownValue: ufDropdownValue ?? this.ufDropdownValue,
        cidadeDropdownValue: cidadeDropdownValue?? this.cidadeDropdownValue,
        usuarioSelecionadoCidade: usuarioSelecionadoCidade??this.usuarioSelecionadoCidade,
        usuarioSelecionadoUF: usuarioSelecionadoUF??this.usuarioSelecionadoUF
        );
  }
}
