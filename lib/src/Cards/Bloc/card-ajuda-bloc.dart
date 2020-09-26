import 'dart:js';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Entidades/Bloc/caminhao-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/carregamentoMercadoria-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/custo-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/embalagem-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/empresa-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/responsavelEmpresa-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/romaneio-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/solicitacaoAbastecimento-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/solicitacaoManutencao-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/solicitacaoTrocaOleo-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/usuario-bloc.dart';

class CardAjudaBloc extends BlocBase {
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
      if (chaveConsulta == null) {
        EmpresaBloc blocEmpresa =
            BlocProvider.of<EmpresaBloc>(contextoAplicacao);
        await blocEmpresa.insereDados(contextoAplicacao);
      } else {
        EmpresaBloc blocEmpresa =
            BlocProvider.of<EmpresaBloc>(contextoAplicacao);
        await blocEmpresa.atualizaDados(contextoAplicacao, chaveConsulta);
      }
    }
    if (origemDado == 'RESPONSAVEL') {
      ResponsavelEmpresaBloc blocResponsavelEmpresa =
          BlocProvider.of<ResponsavelEmpresaBloc>(contextoAplicacao);
      await blocResponsavelEmpresa.insereDados(contextoAplicacao);
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
    if (origemDado == 'RESPONSAVEL') {
      ResponsavelEmpresaBloc blocResponsavelEmpresa =
          BlocProvider.of<ResponsavelEmpresaBloc>(contextoAplicacao);
      await blocResponsavelEmpresa.apagarDados(contextoAplicacao);
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

  @override
  void dispose() {}
}
