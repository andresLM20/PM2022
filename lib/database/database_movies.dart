import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pm2022/models/popular_model.dart';

class DatabaseMovies {
  static final _nombreDb = "MovieFav";
  static final _versionDB = 1;

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(carpeta.path, _nombreDb);
    return await openDatabase(
      rutaBD,
      version: _versionDB, onCreate: _crearTablas, //onUpgrade: _updateTablas
    );
  }

  _crearTablas(Database db, int version) {
    db.execute("CREATE TABLE favorite(id int PRIMARY KEY, title varchar(250))");
  }

  _updateTablas(Database db, int oldVersion, int newVersion) {}
  Future<int> insert(Map<String, dynamic> row) async {
    var dbConexion = await database;
    return dbConexion!
        .insert("favorite", row, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> update(Map<String, dynamic> row) async {
    var dbConexion = await database;
    return dbConexion!
        .update("favorite", row, where: "id = ?", whereArgs: [row['id']]);
  }

  Future<int> delete(int id) async {
    var dbConexion = await database;
    return dbConexion!.delete("favorite", where: "id = ?", whereArgs: [id]);
  }

  Future<List<PopularModel>> getAll() async {
    var dbConexion = await database;
    var result = await dbConexion!.query("favorite");
    var list = result.map((note) => PopularModel.fromJSON(note)).toList();
    return list;
  }

  Future<int> getOne(String id) async {
    var dbConexion = await database;
    var result =
        await dbConexion!.query("favorite", where: "id = ?", whereArgs: [id]);
    var list = result.map((note) => PopularModel.fromJSON(note)).toList();
    return list.length;
  }
}