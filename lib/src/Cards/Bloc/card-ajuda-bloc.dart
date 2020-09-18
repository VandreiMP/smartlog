import 'dart:js';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smartlogproject/src/Entidades/Bloc/caminhao-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/carregamentoMercadoria-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/custo-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/embalagem-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/empresa-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/romaneio-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/solicitacaoAbastecimento-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/solicitacaoManutencao-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/solicitacaoTrocaOleo-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/usuario-bloc.dart';
import 'package:smartlogproject/src/Entidades/classes/solicitacaoTrocaOleo.dart';

class CardAjudaBloc extends BlocBase {
  var _controllerExibeCard = BehaviorSubject<bool>(seedValue: true);
  var _controllerCardAjuda =
      BehaviorSubject<String>(seedValue: 'AcessoSistemaWidget()');

  Stream<bool> get outExibeCard => _controllerExibeCard.stream;
  Stream<String> get outCardAjuda => _controllerCardAjuda.stream;

  final BuildContext contextoAplicacao;
  final String origem;
  final String origemDado;
  final String chaveConsulta;

  CardAjudaBloc(
      this.contextoAplicacao, this.origem, this.origemDado, this.chaveConsulta);

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
      CaminhaoBloc blocCaminhao =
          BlocProvider.of<CaminhaoBloc>(contextoAplicacao);
      await blocCaminhao.insereDados(contextoAplicacao);
    }
    if (origemDado == 'CARGA') {
      CarregamentoMercadoriaBloc blocCarregamentoMercadoria =
          BlocProvider.of<CarregamentoMercadoriaBloc>(contextoAplicacao);
      if (chaveConsulta == null) {
        await blocCarregamentoMercadoria.insereDados(contextoAplicacao);
      } else
        await blocCarregamentoMercadoria.atualizaDados(
            contextoAplicacao, chaveConsulta);
    }
    if (origemDado == 'ROMANEIO') {
      RomaneioBloc blocRomaneio =
          BlocProvider.of<RomaneioBloc>(contextoAplicacao);
      await blocRomaneio.insereDados(contextoAplicacao);
    }
    if (origemDado == 'COMBUSTIVEL') {
      SolicitacaoAbastecimentoBloc blocSolicitacaoAbastecimento =
          BlocProvider.of<SolicitacaoAbastecimentoBloc>(contextoAplicacao);

      await blocSolicitacaoAbastecimento.insereDados(contextoAplicacao);
    }
    if (origemDado == 'OLEO') {
      SolicitacaoTrocaOleoBloc blocSolicitacaoAbastecimento =
          BlocProvider.of<SolicitacaoTrocaOleoBloc>(contextoAplicacao);

      await blocSolicitacaoAbastecimento.insereDados(contextoAplicacao);
    }
    if (origemDado == 'MANUTENCAO') {
      SolicitacaoManutencaoBloc blocSolicitacaoManutencao =
          BlocProvider.of<SolicitacaoManutencaoBloc>(contextoAplicacao);

      await blocSolicitacaoManutencao.insereDados(contextoAplicacao);
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
      CaminhaoBloc blocCaminhao =
          BlocProvider.of<CaminhaoBloc>(contextoAplicacao);
      await blocCaminhao.apagarDados(contextoAplicacao);
    }
    if (origemDado == 'CARGA') {
      CarregamentoMercadoriaBloc blocCarregamentoMercadoria =
          BlocProvider.of<CarregamentoMercadoriaBloc>(contextoAplicacao);
      await blocCarregamentoMercadoria.apagarDados(contextoAplicacao);
    }
    if (origemDado == 'ROMANEIO') {
      RomaneioBloc blocRomaneio =
          BlocProvider.of<RomaneioBloc>(contextoAplicacao);
      await blocRomaneio.apagarDados(contextoAplicacao);
    }
    if (origemDado == 'COMBUSTIVEL') {
      SolicitacaoAbastecimentoBloc blocSolicitacaoAbastecimento =
          BlocProvider.of<SolicitacaoAbastecimentoBloc>(contextoAplicacao);
      await blocSolicitacaoAbastecimento.apagarDados(contextoAplicacao);
    }
    if (origemDado == 'OLEO') {
      SolicitacaoTrocaOleoBloc blocSolicitacaoAbastecimento =
          BlocProvider.of<SolicitacaoTrocaOleoBloc>(contextoAplicacao);
      await blocSolicitacaoAbastecimento.apagarDados(contextoAplicacao);
    }
    if (origemDado == 'MANUTENCAO') {
      SolicitacaoManutencaoBloc blocSolicitacaoManutencao =
          BlocProvider.of<SolicitacaoManutencaoBloc>(contextoAplicacao);
      await blocSolicitacaoManutencao.apagarDados(contextoAplicacao);
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
