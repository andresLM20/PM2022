import 'package:flutter/material.dart';
import 'package:pm2022/database/database_helper.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DatabaseHelper? _database;
  bool ban = false;

  @override
  void initState() {
    super.initState();
    _database=DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtFecha = TextEditingController();
    TextEditingController txtDesc = TextEditingController();
    int idTarea = 0;

    if(ModalRoute.of(context)!.settings.arguments != null){
        final tarea=ModalRoute.of(context)!.settings.arguments as Map;
        ban = true;
        txtFecha.text = tarea['fecEnt'];
        txtDesc.text = tarea['dscTarea'];
        idTarea = tarea['idTarea'];
    }
    final txtFechaEnt = TextField(
      controller: txtFecha,
      //decoration: InputDecoration(enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
      );
    final txtDescTask = TextField(controller: txtDesc, maxLines: 8);

    final btnGuardar = ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 255, 149, 184), // Background color
      ),
      onPressed: (){
        if(!ban){
          _database!.insertar({
            'dscTarea':txtDesc.text,
            'fechaEnt':txtFecha.text}, 
            'tblTareas').then((value) {
              final snackBar = SnackBar(content: Text('Tarea registrada correctamente'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
        }else{
          _database!.actualizar({
            'idTarea': idTarea,
            'dscTarea':txtDesc.text,
            'fechaEnt':txtFecha.text
          }, 'tblTareas').then(
            (value) {
              final snackBar = SnackBar(content: Text('Tarea actualizada'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          );
        }
      }, 
      child: Text('Guardar'));

    return Scaffold(
      appBar: AppBar(
        title: ban == false ? Text('Agregar Tarea') : Text('Modificar Tarea'),
        backgroundColor: Color.fromARGB(255, 255, 149, 184),
      ),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        children: [
          txtFechaEnt,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: txtDescTask,
          ),
          btnGuardar,
        ],
      ),
    );
  }
}