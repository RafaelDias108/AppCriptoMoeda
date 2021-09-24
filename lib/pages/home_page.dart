import 'package:cripto_moedas_app/pages/favoritos_pages.dart';
import 'package:cripto_moedas_app/pages/moedas_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController paginaController;

  //inicializar o PageController
  @override
  void initState() {
    super.initState();
    paginaController = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        // widget que gera páginas roláveis ​​na tela onde podemos ter uma lista fixa de páginas ou uma função de construtor que cria páginas repetidas.
        controller: paginaController,
        children: [
          MoedasPage(),
          FavoritoPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 30,
              ),
              label: 'Todas'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star_border_outlined,
                size: 30,
              ),
              activeIcon: Icon(
                Icons.star,
                size: 30,
                color: Colors.indigo[900],
              ),
              label: 'Favoritos'),
        ],
        onTap: (pagina) {
          paginaController.animateToPage(
            pagina,
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}
