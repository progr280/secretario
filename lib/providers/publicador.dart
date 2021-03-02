import 'package:flutter/foundation.dart';

class Publicador with ChangeNotifier {
  final String id;
  final String nome;
  final bool regular;
  final bool dirigente;
  final String grupo;

  Publicador(
      {@required this.id,
      @required this.nome,
      this.regular = false,
      this.dirigente = false,
      @required this.grupo});
}
