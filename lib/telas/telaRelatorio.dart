import 'package:flutter/material.dart';
import 'package:secretario/providers/publicador.dart';
import 'package:secretario/widgets/int_field.dart';

class TelaRelatorio extends StatefulWidget {
  final Publicador publicador;

  TelaRelatorio({this.publicador});

  @override
  _TelaRelatorioState createState() => _TelaRelatorioState();
}

class _TelaRelatorioState extends State<TelaRelatorio> {
  TextEditingController txtPublicacoes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Relatório"),
      ),
      body: Column(
        children: [
          MyIntField(
            titulo: "Publicações",
            controller: txtPublicacoes,
          ),
          FlatButton(
            onPressed: () {
              print(txtPublicacoes.text);
            },
            child: Text("oi"),
          ),
        ],
      ),
    );
  }
}
