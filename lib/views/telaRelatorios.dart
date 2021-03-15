import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secretario/models/publicador.dart';
import 'package:secretario/providers/publicadores.dart';
import 'package:secretario/views/telaRelatorio.dart';

class TelaRelatorios extends StatefulWidget {
  @override
  _TelaRelatoriosState createState() => _TelaRelatoriosState();
}

class _TelaRelatoriosState extends State<TelaRelatorios> {
  String filtro = '';
  bool exibirPendentes = false;
  int pendentes;
  List<Publicador> _todosOsPublicadores, _publicadores, _dirigentes;

  @override
  @override
  Widget build(BuildContext context) {
    _todosOsPublicadores = Provider.of<Publicadores>(context).publicadores;

    filtro == ''
        ? _publicadores = _todosOsPublicadores
        : _publicadores = _todosOsPublicadores
            .where((element) => element.grupo == filtro)
            .toList();
    pendentes =
        _publicadores.where((element) => !element.participou).toList().length;

    _dirigentes =
        _todosOsPublicadores.where((element) => element.dirigente).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Relatórios"),
      ),
      body: Column(
        children: [
          ListTile(
            tileColor: Colors.grey[300],
            title: filtro.isEmpty
                ? Text("Todos os grupos:")
                : Text("Grupo do $filtro:"),
            trailing: TextButton(
              child: filtro.isEmpty
                  ? Text("Filtrar por grupo")
                  : Text("Todos os grupos"),
              onPressed: () {
                if (filtro.isEmpty) {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 300,
                          child: Column(children: [
                            ListTile(
                              title: Text(
                                "Filtrar por:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: _dirigentes.length,
                                itemBuilder: (context, item) {
                                  return ListTile(
                                    title: Text(_dirigentes[item].nome),
                                    onTap: () {
                                      setState(() {
                                        filtro = _dirigentes[item].nome;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              ),
                            ),
                          ]),
                        );
                      });
                } else {
                  setState(() {
                    filtro = '';
                  });
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _publicadores.length,
              itemBuilder: (context, index) {
                return ListTile(
                  subtitle: Text(_publicadores[index].participou.toString()),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            TelaRelatorio(publicador: _publicadores[index]),
                      ),
                    );
                  },
                  title: Text(_publicadores[index].nome),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ListTile(
        leading: Text("Publ.: ${_publicadores.length.toString()}"),
        trailing: Text("Pendentes: $pendentes"),
      ),
    );
  }
}
