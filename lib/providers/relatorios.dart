import 'dart:math';

import 'package:flutter/material.dart';
import 'package:secretario/providers/publicador.dart';
import 'package:secretario/utils/db_util.dart';
import 'package:secretario/providers/relatorio.dart';

class Relatorios with ChangeNotifier {
  List<Relatorio> _relatorios = [];

  Future<void> loadRelatorios() async {
    final dataList = await DbUtil.getData('relatorios');
    _relatorios = dataList
        .map((item) => Relatorio(
              id: item['id'],
              mes: item['mes'],
              publicacoes: item['publicacoes'],
              videos: item['videos'],
              horas: item['horas'],
              revisitas: item['revisitas'],
              estudos: item['estudos'],
              observacao: item['observacao'],
              publicador: Publicador(
                id: item['id'],
                nome: item['nome'],
                regular: item['regular'],
                dirigente: item['dirigente'],
                grupo: item['grupo'],
              ),
            ))
        .toList();
    notifyListeners();
  }

  List<Relatorio> get relatorios {
    return [..._relatorios];
  }

  int get itemsCount {
    return _relatorios.length;
  }

  Relatorio itemByIndex(int index) {
    return _relatorios[index];
  }

  Future<void> addRelatorio(
      String nome,
      String mes,
      int publicacoes,
      int videos,
      int horas,
      int revisitas,
      int estudos,
      String observacao) async {
    final novoRelatorio = Relatorio(
        id: Random().nextDouble().toString(),
        mes: mes,
        publicacoes: publicacoes,
        videos: videos,
        horas: horas,
        revisitas: revisitas,
        estudos: estudos,
        observacao: observacao,
        publicador: null //Publicador(id: id, nome: nome),
        );

    _relatorios.add(novoRelatorio);

    DbUtil.insert('relatorios', {
      'id': novoRelatorio.id,
      'mes': novoRelatorio.mes,
      'nome': novoRelatorio.publicador.nome,
      'regular': novoRelatorio.publicador.regular,
      'publicacoes': novoRelatorio.publicacoes,
      'videos': novoRelatorio.videos,
      'horas': novoRelatorio.horas,
      'revisitas': novoRelatorio.revisitas,
      'estudos': novoRelatorio.estudos,
      'observacao': novoRelatorio.observacao
    });

    notifyListeners();
  }
}
