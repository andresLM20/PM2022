import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pm2022/models/tareas_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final nombreBD = 'TAREASBD';
  static final versionBD = 2;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null)
      return _database!; //! -> Se conoce como que debe tener valor para retornarla
    return _database = await _initDatabase();
  }

  _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(carpeta.path, nombreBD);
    return await openDatabase(rutaBD, version: versionBD, onCreate: _crearTablas);
  }

  _crearTablas(Database db, int version) async {
    String query =
        "CREATE TABLE tblTareas(idTarea INTEGER PRIMARY KEY, dscTarea VARCHAR(100), fechaEnt DATE)";
    db.execute(query);
  }

  Future<int> insertar(Map<String, dynamic> row, String nomTabla) async {
    var conexion = await database;
    return await conexion.insert(nomTabla, row);
  }

  Future<int> actualizar(Map<String, dynamic> row, String nomTabla) async {
    var conexion = await database;
    return await conexion.update(nomTabla, row,
        where: 'idTarea = ?', whereArgs: [row['idTarea']]);
  }

  Future<int> actualizarPerfil(Map<String, dynamic> row, String nomTabla) async {
    var conexion = await database;
    return await conexion.update(nomTabla, row,
        where: 'idperfil = ?', whereArgs: [row['idperfil']]);
  }

  Future<int> eliminar(int idTarea, String nomTabla) async {
    var conexion = await database;
    return await conexion.delete(
      nomTabla,
      where: 'idTarea = ?',
      whereArgs: [idTarea],
    );
  }

  Future<List<TareasDAO>> getAllTareas() async {
    var conexion = await database;
    var result = await conexion.query('tblTareas');
    print("Inicio");
    print(result);
    print("Fin");
    return result.map((mapTarea) => TareasDAO.fromJSON(mapTarea)).toList();
  }
}
