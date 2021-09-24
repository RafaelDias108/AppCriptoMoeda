import 'package:flutter/material.dart';

class FavoritoPage extends StatefulWidget {
  const FavoritoPage({Key? key}) : super(key: key);

  @override
  _FavoritoPageState createState() => _FavoritoPageState();
}

class _FavoritoPageState extends State<FavoritoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moedas Favoritas'),
        centerTitle: true,
      ),
    );
  }
}
