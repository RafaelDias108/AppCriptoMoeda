import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  late SharedPreferences _prefs;
  Map<String, String> locale = {
    'locale': 'pt_BR',
    'name': 'R\$',
  };

  ///contrutor
  AppSettings() {
    _startSettings();
  }
  _startSettings() async {
    await _startPreferences(); // inicialização do SharedPreferences
    await _readLocale(); //ler o locale que o usuário setou
  }

  /// inicialização das Preferences
  /// uma promessa do tipo void
  Future<void> _startPreferences() async {
    /// Inicializar o sistemna de arquivos por meio do SharedPreferences
    _prefs = await SharedPreferences.getInstance();
  }

  /// método para ler o locale atribuído pelo usuário
  _readLocale() {
    /// caso o valor retorne vazio será atribuído pt-BR
    final local = _prefs.getString('local') ?? 'pt_BR';

    /// caso o valor retorne vazio será atribuído R\$
    final name = _prefs.getString('name') ?? 'R\$';

    /// set do Map locale da linha 6
    locale = {
      'locale': local,
      'name': name,
    };

    /// para notificar as classes que estão usando esse Provider
    notifyListeners();
  }

  ///método público para acessar as preferencias
  setlocale(String local, String name) async {
    await _prefs.setString('local', local);
    await _prefs.setString('name', name);

    /// para atualizar o locale conforme as mudanças e notificar os Listeners
    await _readLocale();
  }
}
