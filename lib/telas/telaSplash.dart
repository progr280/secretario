import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secretario/providers/publicadores.dart';

class TelaSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future:
              Provider.of<Publicadores>(context, listen: false).carregarDados(),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: Text('OK'),
                    )),
    );
  }
}
