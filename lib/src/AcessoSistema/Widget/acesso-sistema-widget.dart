import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartlogproject/src/AcessoSistema/Bloc/acesso-sistema-bloc.dart';
import 'package:smartlogproject/src/Components/checkbox/checkbox-widget.dart';
import 'package:smartlogproject/src/Components/scroll/scroll.dart';
import 'package:smartlogproject/src/Modelos/checkBoxModelo.dart';
import 'package:smartlogproject/src/funcoes/appTextField.dart';

class AcessoSistemaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AcessoSistemaBloc>(
      bloc: AcessoSistemaBloc(context),
      child: Material(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.blue,
            ),
            _FormularioLogin(),
          ],
        ),
      ),
    );
  }
}

class _FormularioLogin extends StatelessWidget {
  /*
    Controllers
    */
  TextEditingController _tUsuario;
  TextEditingController _tSenha;

  String caminhoImagem = 'Images/login.png';
  String nomeFormulario = 'Autenticação do Sistema';

  @override
  Widget build(BuildContext context) {
    AcessoSistemaBloc blocAcesso = BlocProvider.of<AcessoSistemaBloc>(context);
    return Scroll(
      width: double.infinity,
      child: Container(
        padding:
            EdgeInsets.only(top: 70.0, bottom: 70.0, left: 250.0, right: 250.0),
        child: Scroll(
          width: double.infinity,
          child: Card(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: new Border.all(
                  color: Colors.black,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*
                  Logo do formulário
                  */
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: 300, maxHeight: 300),
                          child: Image.asset(caminhoImagem),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /*
                        Título Formulário
                        */
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Container(
                            alignment: Alignment.center,
                            width: 350,
                            height: 30,
                            child: Text(
                              nomeFormulario,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                        /*
                        Campo Usuário
                        */
                        Container(
                          width: 350,
                          height: 30,
                          child: Form(
                            child: TextFormField(
                              controller: _tUsuario,
                              enabled: true,
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                icon: Icon(
                                  FontAwesomeIcons.user,
                                  color: Colors.black,
                                ),
                                enabled: true,
                              ),
                            ),
                          ),
                        ),
                        /*
                        Campo Senha
                        */
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Container(
                            width: 350,
                            height: 30,
                            child: Form(
                              child: TextFormField(
                                controller: _tSenha,
                                obscureText: true,
                                enabled: true,
                                decoration: InputDecoration(
                                  icon: Icon(
                                    FontAwesomeIcons.key,
                                    color: Colors.black,
                                  ),
                                  enabled: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                        /*
                        Checkbox Senha
                        */
                        Container(
                          width: 300.0,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              StreamBuilder<Object>(
                                initialData: false,
                                stream: blocAcesso.outSelecionaCheckBox,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Checkbox(
                                        visualDensity: VisualDensity(
                                            horizontal: 2.0, vertical: 2.0),
                                        value: snapshot.data,
                                        onChanged: (bool novoValor) {
                                          blocAcesso
                                              .eventoCliqueCheckBox(novoValor);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: Container(
                                  child: Text(
                                    'Exibir Senha de Acesso',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        /*
                        Botão de Acesso
                        */
                        StreamBuilder<Object>(
                          stream: blocAcesso.outCarregamento,
                          initialData: false,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return AnimatedCrossFade(
                              firstChild: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: RaisedButton.icon(
                                  textColor: Colors.white,
                                  color: Colors.blueAccent[700],
                                  icon: Icon(FontAwesomeIcons.unlock),
                                  label: Text('Liberar Acesso'),
                                  onPressed: blocAcesso.eventoCliqueBotaoAcesso,
                                ),
                              ),
                              secondChild: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: CircularProgressIndicator(),
                              ),
                              duration: Duration(milliseconds: 500),
                              crossFadeState: snapshot.data
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class _FormularioLogin extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     AcessoSistemaBloc bloc = BlocProvider.of<AcessoSistemaBloc>(context);

//     _botoesFormulario() {
//       return Column(
//         children: [
//           RaisedButton.icon(
//             textColor: Colors.white,
//             color: Colors.green,
//             icon: Icon(FontAwesomeIcons.whatsapp),
//             label: Text('Autenticação com Telefone'),
//             onPressed: bloc.eventoCliqueWhatsapp,
//           ),
//           RaisedButton.icon(
//             textColor: Colors.white,
//             color: Colors.redAccent[400],
//             icon: Icon(FontAwesomeIcons.google),
//             label: Text('Autenticação com Google'),
//             onPressed: bloc.eventoCliqueGoogle,
//           ),
//           RaisedButton.icon(
//             textColor: Colors.white,
//             color: Colors.blue,
//             icon: Icon(FontAwesomeIcons.facebookF),
//             label: Text('Autenticação com Facebook'),
//             onPressed: bloc.eventoCliqueFacebook,
//           )
//         ],
//       );
//     }

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         FlutterLogo(size: 72),
//         Container(
//           height: 120,
//         ),
//         StreamBuilder<Object>(
//             stream: bloc.outCarregamento,
//             initialData: false,
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               return AnimatedCrossFade(
//                 firstChild: _botoesFormulario(),
//                 secondChild: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: CircularProgressIndicator(),
//                 ),
//                 duration: Duration(milliseconds: 500),
//                 crossFadeState: snapshot.data
//                     ? CrossFadeState.showSecond
//                     : CrossFadeState.showFirst,
//               );
//             }),
//       ],
//     );
//   }
// }
