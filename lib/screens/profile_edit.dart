import 'package:flutter/material.dart';
import 'package:pm2022/database/database_helperP.dart';

class ProfileEdit extends StatefulWidget {
  ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  DatabaseHelperP? _database;

  @override
  void initState() {
    super.initState();
    _database=DatabaseHelperP();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtnombre = TextEditingController();
    TextEditingController txtcorreo = TextEditingController();
    TextEditingController txttelefono = TextEditingController();
    TextEditingController txtgithub = TextEditingController();
    int idperfil = 0;

    if(ModalRoute.of(context)!.settings.arguments != null){
        final perfil=ModalRoute.of(context)!.settings.arguments as Map;
        txtnombre.text = perfil['nombre'];
        txtcorreo.text = perfil['correo'];
        txttelefono.text = perfil['telefono'];
        txtgithub.text = perfil['github'];
        idperfil = perfil['idperfil'];
    }
    final txtnombreF = TextField(
      controller: txtnombre,
      decoration: InputDecoration(border: OutlineInputBorder()),
      maxLines: 2,
      );
    final txtcorreoF = TextField(
      controller: txtcorreo,
      decoration: InputDecoration(border: OutlineInputBorder()), 
      maxLines: 2
      );
      final txttelefonoF = TextField(
      controller: txttelefono,
      decoration: InputDecoration(border: OutlineInputBorder()), 
      maxLines: 2
      );
      final txtgithubF = TextField(
      controller: txtgithub,
      decoration: InputDecoration(border: OutlineInputBorder()), 
      maxLines: 2
      );

    final btnGuardar = ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 255, 207, 51), // Background color
      ),
      onPressed: (){
          _database!.actualizarPerfil({
            'idperfil': idperfil,
            'nombre':txtnombre.text,
            'correo':txtcorreo.text,
            'telefono':txttelefono.text,
            'github':txtgithub.text,
          }, 'tblperfil').then(
            (value) {
              final snackBar = SnackBar(content: Text('Datos actualizados'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          );
        },
      child: Text('Guardar'));

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar perfil'),
        backgroundColor: Color.fromARGB(255, 255, 207, 51),
      ),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        children: [
          Text('Nombre:'),
          txtnombreF,
          Text('Correo:'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: txtcorreoF,
          ),
          Text('Teléfono:'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: txttelefonoF,
          ),
          Text('GitHub:'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: txtgithubF,
          ),
          btnGuardar,
        ],
      ),
    );
  }
}