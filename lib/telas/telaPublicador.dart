import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secretario/providers/publicador.dart';
import 'package:secretario/providers/publicadores.dart';

class TelaPublicador extends StatefulWidget {
  final Publicador publicador;

  TelaPublicador({this.publicador});

  @override
  _TelaPublicadorState createState() => _TelaPublicadorState();
}

class _TelaPublicadorState extends State<TelaPublicador> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController txtNome = TextEditingController();
  TextEditingController txtGrupo = TextEditingController();
  bool regular;
  bool dirigente;
  List<Publicador> dirigentes;

  @override
  void initState() {
    super.initState();
    txtNome.text = widget.publicador.nome;
    regular = widget.publicador.regular;
    dirigente = widget.publicador.dirigente;
    txtGrupo.text = widget.publicador.grupo;
    print(widget.publicador.grupo);
  }

  @override
  Widget build(BuildContext context) {
    dirigentes = Provider.of<Publicadores>(context, listen: false).dirigentes;

    return Scaffold(
      appBar: AppBar(
        title: Text("Publicador"),
      ),
      body: Form(
        key: _formKey,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 6, 8),
            child: TextFormField(
              controller: txtNome,
              decoration: InputDecoration(labelText: "Nome"),
              validator: (value) {
                if (value.isEmpty) {
                  return "Esse campo é obrigatório";
                }
                return null;
              },
            ),
          ),
          Container(
            child: ListTile(
              leading: Checkbox(
                value: regular,
                onChanged: (value) {
                  setState(() {
                    regular = value;
                  });
                },
              ),
              title: Text("Pioneiro Regular"),
            ),
          ),
          Container(
            child: ListTile(
              leading: Checkbox(
                  value: dirigente,
                  onChanged: (value) {
                    if (txtNome.text.isEmpty) {
                      setState(() {
                        txtGrupo.text = '';
                      });

                      showDialog(
                          context: context,
                          child: AlertDialog(
                            content: Text(
                                "Antes de ativar essa opção, informe o nome do publicador."),
                            actions: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("OK"))
                            ],
                          ));
                    } else {
                      setState(() {
                        dirigente = value;
                        txtGrupo.text = txtNome.text;
                      });
                    }
                  }),
              title: Text("Dirigente de grupo"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 6, 8),
            child: TextFormField(
              controller: txtGrupo,
              decoration: InputDecoration(labelText: "Grupo"),
              validator: (value) {
                if (value.isEmpty) {
                  return "Esse campo é obrigatório";
                }
                return null;
              },
              readOnly: true,
              onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 300,
                      child: Column(children: [
                        ListTile(
                          title: Text(
                            "Selecione o grupo:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: dirigentes.length,
                            itemBuilder: (context, item) {
                              return ListTile(
                                title: Text(dirigentes[item].nome),
                                onTap: () {
                                  setState(() {
                                    txtGrupo.text = dirigentes[item].nome;
                                  });
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          ),
                        ),
                      ]),
                    );
                  }),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            if (widget.publicador.id == '') {
              Publicador novoPublicador = Publicador(
                  id: Random().nextDouble().toString(),
                  nome: txtNome.text,
                  regular: regular,
                  dirigente: dirigente,
                  grupo: txtGrupo.text);
              Provider.of<Publicadores>(context, listen: false)
                  .addPublicador(novoPublicador);
            } else {
              Publicador publicadorModificado = Publicador(
                id: widget.publicador.id,
                nome: txtNome.text,
                regular: regular,
                dirigente: dirigente,
                grupo: txtGrupo.text,
              );
              Provider.of<Publicadores>(context, listen: false)
                  .updatePublicador(publicadorModificado);
            }
            Provider.of<Publicadores>(context, listen: false).carregarDados();
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
