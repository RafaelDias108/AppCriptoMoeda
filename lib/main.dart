import 'package:cripto_moedas_app/repositories/favoritas_reporitory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritasRepository(),
      child: MyApp(),
    ),
  );
}
