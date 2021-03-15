import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secretario/providers/publicadores.dart';
import 'package:secretario/views/telaPrincipal.dart';
import 'package:secretario/views/telaPublicador.dart';
import 'package:secretario/views/telaPublicadores.dart';

import 'common/routes.dart';

void main() {
  runApp(AppSecretario());
}

class AppSecretario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new Publicadores(),
      child: MaterialApp(
        routes: {
          Routes.TELA_PRINCIPAL: (ctc) => TelaPrincipal(),
          Routes.TELA_PUBLICADORES: (ctc) => TelaPublicadores(),
          Routes.TELA_PUBLICADOR: (ctc) => TelaPublicador(),
        },
        initialRoute: Routes.TELA_PRINCIPAL,
        debugShowCheckedModeBanner: false,
        title: "Secretário",
      ),
    );
  }
}
