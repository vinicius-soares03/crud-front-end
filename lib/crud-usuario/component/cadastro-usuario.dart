import 'package:crud_web/crud-usuario/bloc/crud-usuario-cubit-model.dart';
import 'package:crud_web/crud-usuario/bloc/crud-usuario-cubit.dart';
import 'package:crud_web/crud-usuario/component/usuarios-cadastrados.dart';
import 'package:crud_web/crud-usuario/model/usuario-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brasil_fields/brasil_fields.dart';

import 'home.dart';

class CadastroUsuario extends StatefulWidget {
  const CadastroUsuario({Key? key}) : super(key: key);
  static String ROUTE = '/cadastroUsuario';

  @override
  State<CadastroUsuario> createState() => _CadastroUsuarioState();
}

TextEditingController _nomeController = TextEditingController();
TextEditingController _sobreNomeController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _enderecoController = TextEditingController();
TextEditingController _ufController = TextEditingController();
TextEditingController _cidadeController = TextEditingController();
TextEditingController _cepController = TextEditingController();
TextEditingController _cpfController = TextEditingController();

CrudUsuarioCubit? _bloc;

List<String> _listaCidades = ['São Paulo', 'RONDONÓPOLIS'];
List<String> _listaUF = ['SP', 'MT'];

class _CadastroUsuarioState extends State<CadastroUsuario> {
  String? teste;
  @override
  Widget build(BuildContext context) {
    _bloc = ModalRoute.of(context)?.settings.arguments as CrudUsuarioCubit;
    return BlocProvider.value(
      value: _bloc!,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: _buildAppBar(context),
        ),
        body: _buildBody(context),
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
                  'CADASTRO DE USUÁRIO',
                  maxLines: 1,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              Expanded(child: _retonarFormulario(context))
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _retonarFormulario(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(bottom: 4),
    child: ListView(shrinkWrap: true, children: <Widget>[
      _retornaCampoForms('NOME', _nomeController, TextInputType.text, context,
         ),
      _retornaCampoForms(
          'SOBRENOME', _sobreNomeController, TextInputType.text, context),
      _retornaCampoForms(
          'EMAIL', _emailController, TextInputType.text, context),
      _retornaCampoForms(
          'ENDEREÇO', _enderecoController, TextInputType.text, context),
      _retornaListaCidades(context),
      _retornaListaUF(context),
      _retornaCampoForms('CEP', _cepController, TextInputType.text, context,FilteringTextInputFormatter.digitsOnly, CepInputFormatter()),
      _retornaCampoForms('CPF', _cpfController, TextInputType.text, context, FilteringTextInputFormatter.digitsOnly, CpfInputFormatter()),
      _exibirBotaoCadastrar(context)
    ]),
  );
}

Widget _retornaListaCidades(BuildContext context) {
  return BlocBuilder<CrudUsuarioCubit, CrudUsuarioModel>(
    builder: (context, state) {
      return Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
          width: MediaQuery.of(context).size.width / 1.2,
          child: DropdownButton<String>(
            isExpanded: true,
            value: state.cidadeDropdownValue,
            hint: Container(
                child: Text('CIDADES',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ))),
            onChanged: (String? newValue) {
              _bloc?.atualizarDropDownValueCidade(newValue!);
              _cidadeController.text = newValue!;
            },
            items: _listaCidades.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ));
    },
  );
}

Widget _retornaListaUF(BuildContext context) {
  return BlocBuilder<CrudUsuarioCubit, CrudUsuarioModel>(
    builder: (context, state) {
      return Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
          width: MediaQuery.of(context).size.width / 1.2,
          child: DropdownButton<String>(
            isExpanded: true,
            value: state.ufDropdownValue,
            hint: Container(
                child: Text('UF',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ))),
            onChanged: (String? newValue) {
              _bloc?.atualizarDropDownValueUF(newValue!);
              _ufController.text = newValue!;
            },
            items: _listaUF.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ));
    },
  );
}

Widget _retornaCampoForms(
    String nomeCampo,
    TextEditingController controlador,
    TextInputType tipoTeclado,
    BuildContext context,
    [TextInputFormatter? filter,
    TextInputFormatter? format]) {
  return Container(
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 4),
          alignment: Alignment.topLeft,
          child: Text(nomeCampo,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ),
        Flexible(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromRGBO(228, 226, 222, 1),
            ),
            child: Container(
              child: TextField(
                inputFormatters: [filter?? FilteringTextInputFormatter.singleLineFormatter, format?? FilteringTextInputFormatter.singleLineFormatter,],
                cursorWidth: 1,
                style: TextStyle(fontSize: 16),
                maxLines: null,
                controller: controlador,
                cursorColor: Colors.transparent,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                keyboardType: tipoTeclado,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _exibirBotaoCadastrar(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(left: 32, right: 32, bottom: 4, top: 4),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor, padding: EdgeInsets.all(4)),
      onPressed: () async {
        _bloc?.cadastrarUSuario(Usuario(
            NOME: _nomeController.text,
            SOBRENOME: _sobreNomeController.text,
            EMAIL: _emailController.text,
            ENDERECO: _enderecoController.text,
            CIDADE: _cidadeController.text,
            UF: _ufController.text,
            CEP: _cepController.text,
            CPF: _cpfController.text));
        Navigator.pushNamed(context, UsuariosCadastrados.ROUTE,
            arguments: _bloc);
      },
      child: Text(
        "CADASTRAR",
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
