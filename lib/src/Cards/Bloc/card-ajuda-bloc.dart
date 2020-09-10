import 'dart:js';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/Bloc/caminhao-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/custo-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/embalagem-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/empresa-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/usuario-bloc.dart';

class CardAjudaBloc extends BlocBase {
  var _controllerExibeCard = BehaviorSubject<bool>(seedValue: true);
  var _controllerCardAjuda =
      BehaviorSubject<String>(seedValue: 'AcessoSistemaWidget()');

  Stream<bool> get outExibeCard => _controllerExibeCard.stream;
  Stream<String> get outCardAjuda => _controllerCardAjuda.stream;

  final BuildContext contextoAplicacao;
  final String origem;
  final String origemDado;

  CardAjudaBloc(this.contextoAplicacao, this.origem, this.origemDado);

  Future<void> eventoCliqueBotaoSalvar() async {
    if (origemDado == 'USUARIO') {
      UsuarioBloc blocUsuario = BlocProvider.of<UsuarioBloc>(contextoAplicacao);
      await blocUsuario.insereDados(contextoAplicacao);
    }
    if (origemDado == 'EMBALAGEM') {
      EmbalagemBloc blocEmbalagem =
          BlocProvider.of<EmbalagemBloc>(contextoAplicacao);
      await blocEmbalagem.insereDados(contextoAplicacao);
    }
    if (origemDado == 'CUSTOS') {
      CustoBloc blocCusto = BlocProvider.of<CustoBloc>(contextoAplicacao);
      await blocCusto.insereDados(contextoAplicacao);
    }
    if (origemDado == 'EMPRESA') {
      EmpresaBloc blocEmpresa = BlocProvider.of<EmpresaBloc>(contextoAplicacao);
      await blocEmpresa.insereDados(contextoAplicacao);
    }
    if (origemDado == 'CAMINHAO') {
      CaminhaoBloc blocCaminhao = BlocProvider.of<CaminhaoBloc>(contextoAplicacao);
      await blocCaminhao.insereDados(contextoAplicacao);
    }
  }

  Future<void> eventoCliqueBotaoApagarDados() async {
    if (origemDado == 'USUARIO') {
      UsuarioBloc blocUsuario = BlocProvider.of<UsuarioBloc>(contextoAplicacao);

      await blocUsuario.apagarDados(contextoAplicacao);
    }
    if (origemDado == 'EMBALAGEM') {
      EmbalagemBloc blocEmbalagem =
          BlocProvider.of<EmbalagemBloc>(contextoAplicacao);
      await blocEmbalagem.apagarDados(contextoAplicacao);
    }
    if (origemDado == 'CUSTOS') {
      CustoBloc blocCusto = BlocProvider.of<CustoBloc>(contextoAplicacao);
      await blocCusto.apagarDados(contextoAplicacao);
    }
    if (origemDado == 'EMPRESA') {
      EmpresaBloc blocEmpresa = BlocProvider.of<EmpresaBloc>(contextoAplicacao);
      await blocEmpresa.apagarDados(contextoAplicacao);
    }
    if (origemDado == 'CAMINHAO') {
      CaminhaoBloc blocCaminhao = BlocProvider.of<CaminhaoBloc>(contextoAplicacao);
      await blocCaminhao.apagarDados(contextoAplicacao);
    }
  }

  Future<void> eventoCliqueBotaoAjuda() async {
    _controllerExibeCard.add(!_controllerExibeCard.value);

    // _controllerCardAjuda.add('CriaCardAjudaEmpresa()');

    // if (origem == 'GERAL' ||
    //     origem == 'RESPONSAVEL' ||
    //     origem == 'DESPESAS_CONTRATO') {
    //   _controllerCardAjuda.add(CriaCardAjuda());
    // }
    // if (origem == 'ADICIONAIS') {
    //   _controllerCardAjuda.add(CriaCardAjudaAdicionais());
    // }
    // if (origem == 'DETALHES_CAMINHAO') {
    //   _controllerCardAjuda.add(CriaCardAjudaCaminhaoDetalhes());
    // }
    // if (origem == 'CUSTOS') {
    //   _controllerCardAjuda.add(CriaCardAjudaCustos());
    // }
    // if (origem == 'EMPRESA') {
    //   _controllerCardAjuda.add(CriaCardAjudaEmpresa());
    // }
    // if (origem == 'CONTRATO') {
    //   _controllerCardAjuda.add(CriaCardAjudaContrato());
    // }
    // if (origem == 'CARGA') {
    //   _controllerCardAjuda.add(CriaCardAjudaCarga());
    // }
    // if (origem == 'ROMANEIO') {
    //   _controllerCardAjuda.add(CriaCardAjudaRomaneio());
    // }
  }

  @override
  void dispose() {
    _controllerExibeCard.close();
  }
}
