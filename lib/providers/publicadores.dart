import 'package:flutter/foundation.dart';
import 'package:secretario/common/db.dart';
import 'package:secretario/models/publicador.dart';

class Publicadores extends ChangeNotifier {
  List<Publicador> _publicadores = [];

  Future<void> carregarDados() async {
    List dados = await Db.getData('publicadores');

    _publicadores = dados.map((item) {
      return Publicador(
        id: item['id'],
        nome: item['nome'],
        grupo: item['grupo'],
        dirigente: intToBool(item['dirigente']),
        pioneiroRegular: intToBool(item['pioneiro_regular']),
        pioneiroAuxiliarPorTempoIndeterminado:
            intToBool(item['pioneiro_auxiliar_tempo_indeterminado']),
        pioneiroAuxiliar: intToBool(item['pioneiro_auxiliar']),
        publicacoes: item['publicacoes'],
        videos: item['videos'],
        horas: item['horas'],
        revisitas: item['revisitas'],
        estudos: item['estudos'],
        participou: intToBool(item['participou']),
        observacao: item['observacao'],
        compilado: intToBool(item['compilado']),
      );
    }).toList();
  }

  List<Publicador> get publicadores {
    List<Publicador> lista = [..._publicadores];

    lista.sort((a, b) {
      return a.nome
          .toString()
          .toLowerCase()
          .compareTo(b.nome.toString().toLowerCase());
    });

    return lista;
  }

  int get quantidade {
    return _publicadores.length;
  }

  List<Publicador> get dirigentes {
    return _publicadores.where((element) => element.dirigente).toList();
  }

  Future<void> createPublicador(Publicador publicador) async {
    Db.insert('publicadores', {
      'id': publicador.id,
      'nome': publicador.nome,
      'grupo': publicador.dirigente ? publicador.nome : publicador.grupo,
      'dirigente': publicador.dirigente,
      'pioneiro_regular': publicador.pioneiroRegular,
      'pioneiro_auxiliar_tempo_indeterminado':
          publicador.pioneiroAuxiliarPorTempoIndeterminado,
      'pioneiro_auxiliar': publicador.pioneiroAuxiliarPorTempoIndeterminado
          ? true
          : publicador.pioneiroAuxiliarPorTempoIndeterminado,
      'publicacoes': publicador.publicacoes,
      'videos': publicador.videos,
      'horas': publicador.horas,
      'revisitas': publicador.revisitas,
      'estudos': publicador.estudos,
      'participou': publicador.participou,
      'observacao': publicador.observacao,
      'compilado': publicador.compilado
    });
    _publicadores.add(publicador);
    notifyListeners();
  }
}

bool intToBool(int i) => i == 0 ? false : true;
