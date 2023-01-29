import 'package:karyawan_list/models/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> initDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'karyawan.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    final sql = ''' CREATE TABLE  karyawan(
      id INTEGER PRIMARY KEY,
      nik TEXT,
      nama TEXT,
      umur INTEGER,
      kota TEXT)''';
    await db.execute(sql);
  }

  static Future<int> createList(KaryawanModel karyawan) async {
    Database db = await DBHelper.initDB();
    return await db.insert('karyawan', karyawan.toJson());
  }

  static Future<List<KaryawanModel>> readList() async {
    Database db = await DBHelper.initDB();
    var karyawan = await db.query('karyawan', orderBy: 'nama');

    List<KaryawanModel> karyawanList = karyawan.isNotEmpty
        ? karyawan.map((e) => KaryawanModel.fromJson(e)).toList()
        : [];
    return karyawanList;
  }

  static Future<int> updateList(KaryawanModel karyawan) async {
    Database db = await DBHelper.initDB();

    return await db.update('karyawan', karyawan.toJson(),
        where: 'id = ?', whereArgs: [karyawan.id]);
  }

  static Future<int> deleteList(int id) async {
    Database db = await DBHelper.initDB();
    return await db.delete('karyawan', where: 'id = ?', whereArgs: [id]);
  }

  static Future deleteTable() async {
    Database db = await DBHelper.initDB();
    return await db.rawQuery('DELETE FROM karyawan');
  }
}
