import 'package:flutter/foundation.dart';

class Publicador with ChangeNotifier {
  final String id;
  final String nome;
  final bool regular;
  final bool dirigente;
  final String grupo;
  final int publicacoes;
  final int videos;
  final int horas;
  final int revisitas;
  final int estudos;
  final String observacao;

  Publicador(
      {@required this.id,
      @required this.nome,
      this.regular = false,
      this.dirigente = false,
      @required this.grupo,
      this.publicacoes,
      this.videos,
      this.horas,
      this.revisitas,
      this.estudos,
      this.observacao});
}
