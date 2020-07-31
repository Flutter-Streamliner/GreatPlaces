import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    final dbPath = await getDatabasesPath();
    final sqlDb =
        await openDatabase(join(dbPath, 'places.db'), onCreate: (db, version) {
      db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
    await sqlDb.insert(table, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
