import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secretario/providers/relatorios.dart';
import 'package:secretario/telas/telaPublicador.dart';
import 'package:secretario/telas/telaPublicadores.dart';

import 'package:secretario/utils/routes.dart';

import 'package:secretario/providers/publicadores.dart';

import 'package:secretario/telas/telaPrincipal.dart';

void main() {
  runApp(AppSecretario());
}

class AppSecretario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Publicadores(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Relatorios(),
        ),
      ],
      child: MaterialApp(
        title: "Secretário",
        initialRoute: Routes.TELA_PRINCIPAL,
        debugShowCheckedModeBanner: false,
        routes: {
          Routes.TELA_PRINCIPAL: (ctx) => TelaPrincipal(),
          Routes.TELA_PUBLICADORES: (ctx) => TelaPublicadores(),
          Routes.TELA_PUBLICADOR: (ctx) => TelaPublicador(),
        },
      ),
    );
  }
}
