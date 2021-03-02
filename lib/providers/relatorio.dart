import 'package:flutter/foundation.dart';
import 'package:secretario/providers/publicador.dart';

class Relatorio with ChangeNotifier {
  final String id;
  final String mes;
  final int publicacoes;
  final int videos;
  final int horas;
  final int revisitas;
  final int estudos;
  final String observacao;
  final Publicador publicador;

  Relatorio(
      {@required this.id,
      @required this.mes,
      this.publicacoes,
      this.videos,
      @required this.horas,
      this.revisitas,
      this.estudos,
      this.observacao,
      @required this.publicador});
}
