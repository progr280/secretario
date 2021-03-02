import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secretario/providers/publicadores.dart';
import 'package:secretario/utils/routes.dart';

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Secretário"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, Routes.TELA_PUBLICADORES);
            },
          ),
          IconButton(
            icon: Icon(Icons.ballot),
            onPressed: () {
              Navigator.pushNamed(context, Routes.TELA_PUBLICADORES);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<Publicadores>(context, listen: false).carregarDados(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Text("OK"),
                  ),
      ),
    );
  }
}
