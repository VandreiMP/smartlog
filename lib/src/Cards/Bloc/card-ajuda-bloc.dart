import 'dart:js';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:smartlogproject/src/Entidades/Bloc/caminhao-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/carregamentoMercadoria-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/custo-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/embalagem-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/empresa-bloc.dart';
import 'package:smartlogproject/src/Entidades/Bloc/fichaCaminhao-bloc.dart';
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
      if (chaveConsulta == null) {
        UsuarioBloc blocUsuario =
            BlocProvider.of<UsuarioBloc>(contextoAplicacao);
        await blocUsuario.insereDados(contextoAplicacao);
      } else {
        UsuarioBloc blocUsuario =
            BlocProvider.of<UsuarioBloc>(contextoAplicacao);
        await blocUsuario.atualizaDados(contextoAplicacao);
      }
    }
    if (origemDado == 'EMBALAGEM') {
      if (chaveConsulta == null) {
        EmbalagemBloc blocEmbalagem =
            BlocProvider.of<EmbalagemBloc>(contextoAplicacao);
        await blocEmbalagem.insereDados(contextoAplicacao);
      } else {
        EmbalagemBloc blocEmbalagem =
            BlocProvider.of<EmbalagemBloc>(contextoAplicacao);
        await blocEmbalagem.atualizaDados(contextoAplicacao, chaveConsulta);
      }
    }
    if (origemDado == 'CUSTOS') {
      if (chaveConsulta == null) {
        CustoBloc blocCusto = BlocProvider.of<CustoBloc>(contextoAplicacao);
        await blocCusto.insereDados(contextoAplicacao);
      } else {
        CustoBloc blocCusto = BlocProvider.of<CustoBloc>(contextoAplicacao);
        await blocCusto.atualizaDados(contextoAplicacao);
      }
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
      if (chaveConsulta == null) {
        CaminhaoBloc blocCaminhao =
            BlocProvider.of<CaminhaoBloc>(contextoAplicacao);
        await blocCaminhao.insereDados(contextoAplicacao);
      } else {
        CaminhaoBloc blocCaminhao =
            BlocProvider.of<CaminhaoBloc>(contextoAplicacao);
        await blocCaminhao.atualizaDados(contextoAplicacao);
      }
    }
    if (origemDado == 'DETALHES_CAMINHAO') {
      FichaCaminhaoBloc blocFichaCaminhao =
          BlocProvider.of<FichaCaminhaoBloc>(contextoAplicacao);
      await blocFichaCaminhao.insereDados(contextoAplicacao);
    }
    if (origemDado == 'CARGA') {
      CarregamentoMercadoriaBloc blocCarregamentoMercadoria =
          BlocProvider.of<CarregamentoMercadoriaBloc>(contextoAplicacao);

      if (chaveConsulta == null) {
        await blocCarregamentoMercadoria.insereDados(contextoAplicacao);
      } else
        await blocCarregamentoMercadoria.atualizaDados(
            contextoAplicacao);
    }
    if (origemDado == 'ROMANEIO') {
      if (chaveConsulta == null) {
        RomaneioBloc blocRomaneio =
            BlocProvider.of<RomaneioBloc>(contextoAplicacao);
        await blocRomaneio.insereDados(contextoAplicacao);
      }else {
        RomaneioBloc blocRomaneio =
            BlocProvider.of<RomaneioBloc>(contextoAplicacao);
        await blocRomaneio.atualizaDados(contextoAplicacao);
      }
    }
    if (origemDado == 'COMBUSTIVEL') {
      if (chaveConsulta == null) {
        SolicitacaoAbastecimentoBloc blocSolicitacaoAbastecimento =
            BlocProvider.of<SolicitacaoAbastecimentoBloc>(contextoAplicacao);

        await blocSolicitacaoAbastecimento.insereDados(contextoAplicacao);
      } else {
        SolicitacaoAbastecimentoBloc blocSolicitacaoAbastecimento =
            BlocProvider.of<SolicitacaoAbastecimentoBloc>(contextoAplicacao);

        await blocSolicitacaoAbastecimento.atualizaDados(contextoAplicacao);
      }
    }
    if (origemDado == 'OLEO') {
      if (chaveConsulta == null) {
        SolicitacaoTrocaOleoBloc blocSolicitacaoAbastecimento =
            BlocProvider.of<SolicitacaoTrocaOleoBloc>(contextoAplicacao);
        await blocSolicitacaoAbastecimento.insereDados(contextoAplicacao);
      } else {
        SolicitacaoTrocaOleoBloc blocSolicitacaoAbastecimento =
            BlocProvider.of<SolicitacaoTrocaOleoBloc>(contextoAplicacao);
        await blocSolicitacaoAbastecimento.atualizaDados(contextoAplicacao);
      }
    }
    if (origemDado == 'MANUTENCAO') {
      if (chaveConsulta == null) {
        SolicitacaoManutencaoBloc blocSolicitacaoManutencao =
            BlocProvider.of<SolicitacaoManutencaoBloc>(contextoAplicacao);

        await blocSolicitacaoManutencao.insereDados(contextoAplicacao);
      } else {
        SolicitacaoManutencaoBloc blocSolicitacaoManutencao =
            BlocProvider.of<SolicitacaoManutencaoBloc>(contextoAplicacao);

        await blocSolicitacaoManutencao.atualizaDados(contextoAplicacao);
      }
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
    if (origemDado == 'DETALHES_CAMINHAO') {
      FichaCaminhaoBloc blocFichaCaminhao =
          BlocProvider.of<FichaCaminhaoBloc>(contextoAplicacao);
      await blocFichaCaminhao.apagarDados(contextoAplicacao);
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
