import 'package:flutter/foundation.dart';

class Publicador {
  String id;
  String nome;
  String grupo;
  bool dirigente;
  bool pioneiroRegular;
  bool pioneiroAuxiliarPorTempoIndeterminado;
  bool pioneiroAuxiliar;
  int publicacoes;
  int videos;
  int horas;
  int revisitas;
  int estudos;
  bool participou;
  String observacao;
  bool compilado;

  Publicador(
      {@required this.id,
      @required this.nome,
      @required this.grupo,
      this.dirigente = false,
      this.pioneiroRegular = false,
      this.pioneiroAuxiliarPorTempoIndeterminado = false,
      this.pioneiroAuxiliar = false,
      this.publicacoes,
      this.videos,
      this.horas,
      this.revisitas,
      this.estudos,
      this.participou = false,
      this.observacao,
      this.compilado = false});
}
