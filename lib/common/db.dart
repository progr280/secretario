import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'secretario.db'),
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE publicadores("
            "id TEXT PRIMARY KEY,"
            "nome TEXT,"
            "grupo TEXT,"
            "dirigente BOOL,"
            "pioneiro_regular BOOL,"
            "pioneiro_auxiliar_tempo_indeterminado BOOL,"
            "pioneiro_auxiliar BOOL,"
            "publicacoes INT,"
            "videos INT,"
            "horas INT,"
            "revisitas INT,"
            "estudos INT,"
            "participou BOOL,"
            "observacao STRING,"
            "compilado BOOL"
            ")");
      },
      version: 1,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await Db.database();
    return db.query(table);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await Db.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(String table, Map<String, Object> data) async {
    final db = await Db.database();
    await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> delete(String table, String id) async {
    final db = await Db.database();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
