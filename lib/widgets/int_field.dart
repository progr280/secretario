import 'package:flutter/material.dart';

class MyIntField extends StatefulWidget {
  final String titulo;
  final int valor;

  MyIntField({this.titulo, this.valor});

  @override
  _MyIntFieldState createState() => _MyIntFieldState();
}

class _MyIntFieldState extends State<MyIntField> {
  String titulo;
  int valor;

  @override
  void initState() {
    super.initState();
    valor = widget.valor;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 60,
        height: 60,
        child: RaisedButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              valor++;
            });
          },
        ),
      ),
      title: Text(widget.titulo),
      subtitle: Text(valor.toString()),
      trailing: Container(
        width: 60,
        height: 60,
        child: RaisedButton(
          child: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              valor--;
            });
          },
        ),
      ),
    );
  }
}
