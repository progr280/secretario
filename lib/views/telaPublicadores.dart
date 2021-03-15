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
  List<Publicador> todosOsPublicadores, publicadores;

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<Publicadores>();
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
                    builder: (_) =>
                        TelaPublicador(publicador: novoPublicador)));
              },
            ),
          ],
        ),
        body: Column(children: [
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
                            Consumer<Publicadores>(
                              builder: (context, publicadores, child) =>
                                  ListView(
                                children: [child],
                              ),
                              child: Text("oi"),
                            )
                            // Expanded(
                            //   child: ListView.builder(
                            //     itemCount: dirigentes.length,
                            //     itemBuilder: (context, item) {
                            //       return
                            //     },
                            //   ),
                            // ),
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
                  itemCount: provider.quantidade,
                  itemBuilder: (context, item) {
                    return ListTile(
                      title: Text(
                        provider.publicadores[item].nome,
                      ),
                      subtitle: Text(provider.publicadores[item].dirigente
                          ? "Sim"
                          : "Não"),
                    );
                  })),
        ])
        //   child: ListView.builder(
        //     itemCount: publicadores.length,
        //     itemBuilder: (context, index) {
        //       return Dismissible(
        //         key: ValueKey(publicadores[index].id),
        //         background: Container(
        //           padding: EdgeInsets.only(left: 16),
        //           alignment: Alignment.centerLeft,
        //           color: Theme.of(context).accentColor,
        //           child: Icon(
        //             Icons.edit,
        //             color: Colors.white,
        //           ),
        //         ),
        //         secondaryBackground: Container(
        //           padding: EdgeInsets.only(right: 16),
        //           alignment: Alignment.centerRight,
        //           color: Theme.of(context).errorColor,
        //           child: Icon(
        //             Icons.delete,
        //             color: Colors.white,
        //           ),
        //         ),
        //         confirmDismiss: (direction) {
        //           if (direction == DismissDirection.endToStart) {
        //             return showDialog(
        //               context: context,
        //               builder: (ctx) => AlertDialog(
        //                 title: Text('Excluir publicador'),
        //                 content: Text(
        //                     'Tem certeza que deseja excluir esse publicador?'),
        //                 actions: [
        //                   TextButton(
        //                     onPressed: () {
        //                       Navigator.of(ctx).pop(false);
        //                     },
        //                     child: Text('Não'),
        //                   ),
        //                   TextButton(
        //                     onPressed: () {
        //                       Navigator.of(ctx).pop(true);
        //                       Provider.of<Publicadores>(context,
        //                               listen: false)
        //                           .deletePublicador(publicadores[index]);
        //                       Provider.of<Publicadores>(context,
        //                               listen: false)
        //                           .carregarDados();
        //                     },
        //                     child: Text('Sim'),
        //                   ),
        //                 ],
        //               ),
        //             );
        //           } else {
        //             Navigator.of(context).push(
        //               MaterialPageRoute(
        //                 builder: (_) =>
        //                     TelaPublicador(publicador: publicadores[index]),
        //               ),
        //             );
        //           }
        //           return null;
        //         },
        //         child: ListTile(
        //           onTap: () {
        //             Navigator.of(context).push(
        //               MaterialPageRoute(
        //                 builder: (_) =>
        //                     // TelaRelatorio(publicador: publicadores[index]),
        //               ),
        //             );
        //           },
        //           title: Text(publicadores[index].nome),
        //         ),
        //       );
        //     },
        //   ),
        // ),
        );
  }
}
