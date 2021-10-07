import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// classe do banco de dados
class DB {
  ///criar contrutor com acesso privado
  DB._();

  ///criar uma instância de DB
  static final DB instance = DB._();

  ///criar a instância do SQlite
  static Database? _database;

  ///método get
  get database async {
    ///verifica se o database não é nulo retorna o DB
    ///caso contrário inicializa o DB
    if (_database != null) {
      return _database;
    } else {
      return await _initDatabase();
    }
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'cripto.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  ///definir as operações de criação das tabelas do DB
  _onCreate(db, version) async {
    await db.execute(_conta); //salvar conta com saldo
    await db.execute(_carteira); //posições de moedas que foi comprado
    await db.execute(_historico); //histórico das operações
    await db
        .insert('conta', {'saldo': 0}); //inserir a conta com saldo inicializado
  }

  ///estruturas SQL
  ///
  String get _conta => '''
  CREATE TABLE conta (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    saldo REAL
  );
  ''';

  ///
  String get _carteira => '''
  CREATE TABLE carteira (
    sigla TEXT PRIMARY KEY,
    moeda TEXT,
    quantidade TEXT
  );
  ''';

  ///
  String get _historico => '''
  CREATE TABLE historico (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data_operacao INT,
    tipo_operacao TEXT,
    moeda TEXT,
    sigla TEXT,
    valor REAL,
    quantidade TEXT
  );
  ''';
}
