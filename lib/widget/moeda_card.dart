import 'package:cripto_moedas_app/configs/app_settings.dart';
import 'package:cripto_moedas_app/models/moeda.dart';
import 'package:cripto_moedas_app/pages/moedas_detalhes_page.dart';
import 'package:cripto_moedas_app/repositories/favoritas_reporitory.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoedaCard extends StatefulWidget {
  Moeda moeda;

  MoedaCard({Key? key, required this.moeda}) : super(key: key);

  @override
  _MoedaCardState createState() => _MoedaCardState();
}

class _MoedaCardState extends State<MoedaCard> {
  ///formata a moeda
  late NumberFormat real;

  ///fica armazenado as preferencias da localização
  late Map<String, String> localizacao;

  static Map<String, Color> precoColor = <String, Color>{
    'up': Colors.teal,
    'down': Colors.indigo,
  };

  ///inicialização da localização e do NumberFormat
  readNumberFormat() {
    localizacao = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(
      locale: localizacao['locale'],
      name: localizacao['name'],
    );
  }

  abrirDetalhes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MoedasDetalhesPage(moeda: widget.moeda),
      ),
    );
  }

  removerMoedaFavoritos() {
    Navigator.pop(context);
    Provider.of<FavoritasRepository>(context, listen: false)
        .remove(widget.moeda);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Removido com sucesso !',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// para carregar o locale
    readNumberFormat();

    return Card(
      margin: EdgeInsets.only(top: 12),
      elevation: 2,
      child: InkWell(
        onTap: () => abrirDetalhes(),
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
          child: Row(
            children: [
              Image.asset(
                widget.moeda.icone,
                width: 40,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.moeda.nome,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.moeda.sigla,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: precoColor['down']!.withOpacity(0.05),
                  border: Border.all(
                    color: precoColor['down']!.withOpacity(0.04),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  real.format(widget.moeda.preco),
                  style: TextStyle(
                    fontSize: 16,
                    color: precoColor['down'],
                    letterSpacing: -1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5, left: 5),
                child: PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: ListTile(
                        title: Text('Remover das Favoritas'),
                        onTap: removerMoedaFavoritos,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
