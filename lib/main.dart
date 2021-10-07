import 'package:cripto_moedas_app/configs/app_settings.dart';
import 'package:cripto_moedas_app/repositories/conta_repository.dart';
import 'package:cripto_moedas_app/repositories/favoritas_reporitory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_app.dart';

/*
ChangeNotifierProvider:
Ouve um ChangeNotifier , expõe-o aos seus descendentes e reconstrói os dependentes sempre que ChangeNotifier.notifyListeners é chamado.
*/
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContaRepository()),
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(create: (context) => FavoritasRepository()),
      ],
      child: MyApp(),
    ),
  );
}
