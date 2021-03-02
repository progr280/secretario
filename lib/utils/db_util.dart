import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbUtil {
  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'secretario.db'),
      onCreate: (db, version) async {
        print('===> Criando tabela relatorios');
        await db.execute("CREATE TABLE relatorios("
            "id TEXT PRIMARY KEY,"
            "mes TEXT,"
            "nome TEXT,"
            "regular BOOL,"
            "publicacoes INT,"
            "videos INT,"
            "horas INT,"
            "revisitas INT,"
            "estudos INT,"
            "observacao STRING"
            ")");
        print('===> Criando tabela publicadores');
        await db.execute("CREATE TABLE publicadores("
            "id TEXT PRIMARY KEY,"
            "nome TEXT,"
            "regular BOOL,"
            "dirigente BOOL,"
            "grupo TEXT"
            ")");
        print('===> Tabelas criadas');
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

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }
}
