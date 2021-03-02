import 'package:flutter/material.dart';
import 'package:secretario/utils/db_util.dart';
import './publicador.dart';

class Publicadores with ChangeNotifier {
  List<Publicador> _publicadores = [];

  Future<void> carregarDados() async {
    List dados = await DbUtil.getData('publicadores');

    _publicadores = dados
        .map((item) => Publicador(
            id: item['id'],
            nome: item['nome'],
            regular: intToBool(item['regular']),
            dirigente: intToBool(item['dirigente']),
            grupo: item['grupo']))
        .toList();

    notifyListeners();
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

  Publicador itemByIndex(int index) {
    return _publicadores[index];
  }

  Future<void> addPublicador(Publicador novoPublicador) async {
    _publicadores.add(novoPublicador);
    DbUtil.insert('publicadores', {
      'id': novoPublicador.id,
      'nome': novoPublicador.nome,
      'regular': novoPublicador.regular,
      'dirigente': novoPublicador.dirigente,
      'grupo':
          novoPublicador.dirigente ? novoPublicador.nome : novoPublicador.grupo
    });
    notifyListeners();
  }

  Future<void> updatePublicador(Publicador publicador) async {
    DbUtil.update('publicadores', {
      'id': publicador.id,
      'nome': publicador.nome,
      'regular': publicador.regular,
      'dirigente': publicador.dirigente,
      'grupo': publicador.dirigente ? publicador.nome : publicador.grupo
    });
    notifyListeners();
  }

  Future<void> deletePublicador(Publicador publicador) async {
    DbUtil.delete('publicadores', publicador.id);
    notifyListeners();
  }
}

bool intToBool(int i) => i == 0 ? false : true;
