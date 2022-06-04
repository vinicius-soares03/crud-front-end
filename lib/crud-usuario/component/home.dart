import 'package:crud_web/API/service.dart';
import 'package:crud_web/crud-usuario/bloc/crud-usuario-cubit.dart';
import 'package:crud_web/crud-usuario/component/cadastro-usuario.dart';
import 'package:crud_web/crud-usuario/component/usuarios-cadastrados.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static String ROUTE = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CrudUsuarioCubit? _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = CrudUsuarioCubit();
    return BlocProvider(
        create: (BuildContext context) {
          _bloc = CrudUsuarioCubit();
          return _bloc!;
        },
        child: Scaffold(
          appBar: new PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: _buildAppBar(context),
          ),
          body: _buildBody(context),
        ));
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
    return Container(
      decoration: const BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/imagemBackground.png'),
              fit: BoxFit.fill)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: const Text(
                'Seja bem vindo ao gerenciador de usuários, para adicionar um usuário, clique no icone abaixo',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 32, color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 8),
              width: MediaQuery.of(context).size.width / 2,
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent),
                  onPressed: () async {
                    Navigator.pushNamed(context, CadastroUsuario.ROUTE,
                        arguments: _bloc);
                  },
                  child: Image.asset(
                    'assets/botaoAdicionar.png',
                    height: 100,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
