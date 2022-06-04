import 'package:crud_web/crud-usuario/bloc/crud-usuario-cubit-model.dart';
import 'package:crud_web/crud-usuario/bloc/crud-usuario-cubit.dart';
import 'package:crud_web/crud-usuario/component/cadastro-usuario.dart';
import 'package:crud_web/crud-usuario/component/usuario-selecionado.dart';
import 'package:crud_web/crud-usuario/model/usuario-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

class UsuariosCadastrados extends StatefulWidget {
  const UsuariosCadastrados({Key? key}) : super(key: key);
  static String ROUTE = '/UsuariosCadastrados';

  @override
  State<UsuariosCadastrados> createState() => _UsuariosCadastradosState();
}

CrudUsuarioCubit? _bloc;

class _UsuariosCadastradosState extends State<UsuariosCadastrados> {
  String? teste;

  @override
  Widget build(BuildContext context) {
    _bloc = ModalRoute.of(context)?.settings.arguments as CrudUsuarioCubit;
    _bloc?.buscarUsuarios();
    return BlocProvider.value(
      value: _bloc!,
      child: BlocBuilder<CrudUsuarioCubit, CrudUsuarioModel>(
        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: _buildAppBar(context),
            ),
            body: _buildBody(context),
          );
        },
      ),
    );
  }
}


  Widget _buildAppBar(context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Container(
        child: Image.asset(
          'assets/logo2.png',
          fit: BoxFit.fitHeight,
          scale: 1,
        ),
      ),
      actions: [
        Container(
          padding: EdgeInsets.only(top: 16),
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Home.ROUTE, arguments: _bloc);
                },
                child: const Text(
                  'HOME',
                  style: TextStyle(color: Color(0xFF4B4A4A), fontSize: 16),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, CadastroUsuario.ROUTE,
                      arguments: _bloc);
                },
                child: const Text(
                  'CADASTRAR',
                  style: const TextStyle(color: Color(0xFF4B4A4A), fontSize: 16),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, UsuariosCadastrados.ROUTE,
                      arguments: _bloc);
                },
                child: const Text(
                  'USUÁRIOS',
                  style: TextStyle(color: const Color(0xFF4B4A4A), fontSize: 16),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'SOBRE NÓS',
                  style: TextStyle(color: Color(0xFF4B4A4A), fontSize: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/avatar.png',
                  width: 50,
                  scale: 5,
                ),
              )
            ],
          ),
        )
      ],
    );
  }


Widget _buildBody(context) {
  return BlocBuilder<CrudUsuarioCubit, CrudUsuarioModel>(
    builder: (context, state) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/imagemBackground.png'),
                fit: BoxFit.fill)),
        child: Container(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Color(0xFFA1A1A1))),
            child: Container(
              margin: EdgeInsets.only(right: 8, left: 8, top: 8),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      'USUÁRIOS CADASTRADOS',
                      maxLines: 1,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                  _retornarListaUsuariosCadastrados(context)
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget _retornarListaUsuariosCadastrados(BuildContext context) {
  return BlocBuilder<CrudUsuarioCubit, CrudUsuarioModel>(
    builder: (context, state) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.4,
                padding: const EdgeInsets.only(top: 20, bottom: 8),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    itemCount: state.listaUsuarios!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _bloc?.usuarioSelecionado =
                              state.listaUsuarios![index];
                          Navigator.pushNamed(context, UsuarioSelecionado.ROUTE,
                              arguments: _bloc);
                        },
                        child: Container(
                          child: ListTile(
                            leading: Container(
                              height: MediaQuery.of(context).size.height / 8,
                              width: MediaQuery.of(context).size.width / 10,
                              child: Image.asset(
                                'assets/avatar.png',
                                height: 50,
                                width: 50,
                              ),
                            ),
                            title: Text(
                              "${state.listaUsuarios![index].NOME}",
                              style: TextStyle(fontSize: 16),
                            ),
                            subtitle: Text(
                              "${state.listaUsuarios![index].ENDERECO}",
                              style: TextStyle(fontSize: 16),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    })),
          ],
        ),
      );
    },
  );
}
