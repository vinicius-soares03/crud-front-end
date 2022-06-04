import 'dart:convert';
import 'dart:typed_data';
import 'package:crud_web/API/service.dart';
import 'package:crud_web/crud-usuario/model/usuario-viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'crud-usuario-cubit-action.dart';
import 'crud-usuario-cubit-model.dart';

class CrudUsuarioCubit extends Cubit<CrudUsuarioModel>
    implements CrudUsuarioCubitAction {
  CrudUsuarioCubit()
      : super(new CrudUsuarioModel(exemplo: 'teste', listaUsuarios: []));

  Service _service = new Service();
  Usuario usuarioSelecionado = new Usuario();
  String? itemSelecionado;


  void buscarUsuarios() async {
    List<Usuario>? request = await _service.buscarTodosUsuarios();
    emit(state.patchState(listaUsuarios: request));
  }

  Future<bool?> cadastrarUSuario(Usuario usuario) async {
    bool? request = await _service.cadastrarUsuario(usuario);

    return request;
  }

  Future<bool?> alterarUsuario(Usuario usuario) async {
    bool? request = await _service.alterarUsuario(usuario);

    return request;
  }

  Future<bool?> deletarUsuario(int id) async {
    bool? request = await _service.deletarUsuario(id);
    return request;
  }

  void atualizarDropDownValueUF(String novoValor) {
    emit(state.patchState(ufDropdownValue: novoValor));
  }

  void atualizarDropDownValueCidade(String novoValor) {
    emit(state.patchState(cidadeDropdownValue: novoValor));
  }

  void atualizarUsuarioSelecionadoCidade(String novoValor) {
      emit(state.patchState(usuarioSelecionadoCidade: novoValor));
  }
  void atualizarUsuarioSelecionadoUF(String novoValor) {
      emit(state.patchState(usuarioSelecionadoUF: novoValor));
  }
}
