import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secretario/models/publicador.dart';

class TelaRelatorio extends StatefulWidget {
  final Publicador publicador;

  TelaRelatorio({this.publicador});

  @override
  _TelaRelatorioState createState() => _TelaRelatorioState();
}

class _TelaRelatorioState extends State<TelaRelatorio> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtPublicacoes = new TextEditingController();
  TextEditingController txtVideos = new TextEditingController();
  TextEditingController txtHoras = new TextEditingController();
  TextEditingController txtRevisitas = new TextEditingController();
  TextEditingController txtEstudos = new TextEditingController();
  TextEditingController txtObservacao = new TextEditingController();

  bool participou = false;

  @override
  void initState() {
    super.initState();
    txtPublicacoes.text = '';
    txtVideos.text = '';
    txtHoras.text = '';
    txtRevisitas.text = '';
    txtEstudos.text = '';
    txtObservacao.text = '';
  }

  @override
  Widget build(BuildContext context) {
    print(txtRevisitas);
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.publicador.nome}"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 6, 8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: txtPublicacoes,
                  decoration: InputDecoration(labelText: "Publicações"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isNotEmpty) {
                      try {
                        int.parse(value);
                      } catch (e) {
                        return "O valor deve ser inteiro";
                      }
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: txtVideos,
                  decoration: InputDecoration(labelText: "Vídeos"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isNotEmpty) {
                      try {
                        int.parse(value);
                      } catch (e) {
                        return "O valor deve ser inteiro";
                      }
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: txtHoras,
                  decoration: InputDecoration(labelText: "Horas"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Esse valor é obrigatório";
                    } else {
                      try {
                        int.parse(value);
                      } catch (e) {
                        return "O valor deve ser inteiro";
                      }
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: txtRevisitas,
                  decoration: InputDecoration(labelText: "Revisitas"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isNotEmpty) {
                      try {
                        int.parse(value);
                      } catch (e) {
                        return "O valor deve ser inteiro";
                      }
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: txtEstudos,
                  decoration: InputDecoration(labelText: "Estudos"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isNotEmpty) {
                      try {
                        int.parse(value);
                      } catch (e) {
                        return "O valor deve ser inteiro";
                      }
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: txtObservacao,
                  decoration: InputDecoration(labelText: "Observação"),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Participou no ministério"),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Estudos: ${txtHoras.value}");
          return null;
          if (_formKey.currentState.validate()) {
            if (int.parse(txtRevisitas.text) < int.parse(txtEstudos.text)) {
              print("Erro nas revisitas");
              return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Atenção'),
                        content: Text(
                            "A quantidade de revisitas informada está incorreta."),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("OK"))
                        ],
                      ));
            } else {
              print("Tudo ok");
            }
          }
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
