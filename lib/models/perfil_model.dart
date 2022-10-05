class PerfilDAO {
  int? idperfil;
  String? imagen;
  String? nombre;
  String? correo;
  String? telefono;
  String? github;

  PerfilDAO({this.idperfil, this.imagen, this.nombre, this.correo, this.telefono, this.github});
  factory PerfilDAO.fromJSON(Map<String, dynamic> mapPerfil) {
    return PerfilDAO(
        idperfil: mapPerfil['idperfil'],
        imagen: mapPerfil['imagen'],
        nombre: mapPerfil['nombre'],
        correo: mapPerfil['correo'],
        telefono: mapPerfil['telefono'],
        github: mapPerfil['github'],
    );
  }
}
