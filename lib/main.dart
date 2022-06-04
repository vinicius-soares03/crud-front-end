import 'package:crud_web/crud-usuario/component/cadastro-usuario.dart';
import 'package:crud_web/crud-usuario/component/home.dart';
import 'package:crud_web/crud-usuario/component/usuario-selecionado.dart';
import 'package:crud_web/crud-usuario/component/usuarios-cadastrados.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crud Usuario',
      theme: ThemeData(
        primaryColor: Color(0xFF01c0da),
      ),
      home: Home(),
      routes: {
        CadastroUsuario.ROUTE: (context) => new CadastroUsuario(),
        Home.ROUTE: (context) => new Home(),
        UsuariosCadastrados.ROUTE:(context) => new  UsuariosCadastrados(),
        UsuarioSelecionado.ROUTE:(context) => new UsuarioSelecionado()
      },
    );
  }
}
