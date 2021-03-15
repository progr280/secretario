import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secretario/models/publicador.dart';
import 'package:secretario/providers/publicadores.dart';
import 'package:secretario/views/telaPublicador.dart';

class TelaPublicadores extends StatefulWidget {
  @override
  _TelaPublicadoresState createState() => _TelaPublicadoresState();
}

class _TelaPublicadoresState extends State<TelaPublicadores> {
  String filtro = '';
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

    _dirigentes =
        _todosOsPublicadores.where((element) => element.dirigente).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Publicadores"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Publicador novoPublicador =
                  Publicador(id: '', nome: '', grupo: '');
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => TelaPublicador(publicador: novoPublicador)));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            tileColor: Colors.grey[300],
            title: filtro.isEmpty
                ? Text("Todos os grupos:")
                : Text("Grupo do $filtro:"),
            trailing: TextButton(
              child: filtro.isEmpty ? Text("Filtrar") : Text("Não Filtrar"),
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
                return Dismissible(
                  key: ValueKey(_publicadores[index].id),
                  background: Container(
                    padding: EdgeInsets.only(right: 16),
                    alignment: Alignment.centerRight,
                    color: Theme.of(context).errorColor,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  confirmDismiss: (direction) {
                    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Excluir publicador'),
                        content: Text(
                            'Tem certeza que deseja excluir esse publicador?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop(false);
                            },
                            child: Text('Não'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop(true);
                              Provider.of<Publicadores>(context, listen: false)
                                  .deletePublicador(_publicadores[index]);
                              Provider.of<Publicadores>(context, listen: false)
                                  .carregarDados();
                            },
                            child: Text('Sim'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              TelaPublicador(publicador: _publicadores[index]),
                        ),
                      );
                    },
                    title: Text(_publicadores[index].nome),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
