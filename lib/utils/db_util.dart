import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbUtil {
  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'secretario.db'),
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE publicadores("
            "id TEXT PRIMARY KEY,"
            "nome TEXT,"
            "regular BOOL,"
            "dirigente BOOL,"
            "grupo TEXT,"
            "publicacoes INT,"
            "videos INT,"
            "horas INT,"
            "revisitas INT,"
            "estudos INT,"
            "observacao STRING"
            ")");
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> delete(String table, String id) async {
    final db = await DbUtil.database();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }
}
