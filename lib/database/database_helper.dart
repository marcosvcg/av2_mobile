import 'package:cardapio/models/comentario.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _databaseName = 'cardapio.db';
  static const String _tableName = 'comentarios';

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

   get database async {
    if (_database != null) return _database;
    
    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: 1,
      onCreate: _onCreate
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        itemTitulo TEXT,
        titulo TEXT,
        comentario TEXT
      )
    ''');
  }

  Future<List<Comentario>> getComentarios(String itemTitulo) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'itemTitulo = ?',
      whereArgs: [itemTitulo],
    );
    return List.generate(maps.length, (i) {
      return Comentario(
        id: maps[i]['id'],
        itemTitulo: maps[i]['itemTitulo'],
        titulo: maps[i]['titulo'],
        comentario: maps[i]['comentario'],
      );
    });
  }
}
