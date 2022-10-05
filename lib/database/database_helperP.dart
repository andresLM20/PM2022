import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pm2022/models/perfil_model.dart';
import 'package:pm2022/models/tareas_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperP {
  static final nombreBD = 'PerfilBD';
  static final versionBD = 1;

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
    String query2 =
        "CREATE TABLE tblperfil(idperfil INTEGER PRIMARY KEY, imagen VARCHAR(100), nombre VARCHAR(100), correo VARCHAR(100), telefono VARCHAR(10), github VARCHAR(100));";
    db.execute(query2);
    String query3 =
        'INSERT INTO tblperfil(idperfil,imagen,nombre,correo,telefono,github) VALUES(0,"assets/cuphead.png","Andrea Morales Martínez","18030666@itcelaya.edu.mx","4612917743","https://www.github.com/andresLM20")';
    db.rawInsert(query3);
  }

  Future<int> insertar(Map<String, dynamic> row, String nomTabla) async {
    var conexion = await database;
    return await conexion.insert(nomTabla, row);
  }

  Future<int> actualizarPerfil(Map<String, dynamic> row, String nomTabla) async {
    var conexion = await database;
    return await conexion.update(nomTabla, row,
        where: 'idperfil = ?', whereArgs: [row['idperfil']]);
  }

  Future<List<PerfilDAO>> getPerfil() async {
    var conexion = await database;
    var result = await conexion.query('tblperfil');
    print("Inicio desde helperP");
    print(result);
    print("Fin");
    return result.map((mapPerfil) => PerfilDAO.fromJSON(mapPerfil)).toList();
  }
}
