import 'package:flutter/material.dart';

class MyIntField extends StatefulWidget {
  final String titulo;
  final TextEditingController controller;

  MyIntField({this.titulo, this.controller});

  @override
  _MyIntFieldState createState() => _MyIntFieldState();
}

class _MyIntFieldState extends State<MyIntField> {
  int valor;

  @override
  void initState() {
    super.initState();
    valor = 0;
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
              widget.controller.text = '10';
              //incrementa
            });
          },
        ),
      ),
      title: Text(widget.titulo),
      subtitle: Text(widget.controller.text),
      trailing: Container(
        width: 60,
        height: 60,
        child: RaisedButton(
          child: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              //decrementa
            });
          },
        ),
      ),
    );
  }
}
