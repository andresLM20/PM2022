import 'package:pm2022/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:pm2022/screens/task_screen.dart';

import '../models/tareas_model.dart';

class ListTaskScreen extends StatefulWidget {
  ListTaskScreen ({Key? key}) : super(key: key);

  @override
  State<ListTaskScreen> createState() => _ListTaskScreenState();
}

class _ListTaskScreenState extends State<ListTaskScreen> {
  DatabaseHelper? _database;

  @override
  void initState() {
    super.initState();
    _database=DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 149, 184),
        title: Text('List Tasks'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add').then((value) {setState(() {
              });});
            }, 
            icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: _database!.getAllTareas(),
        builder:(context, AsyncSnapshot<List<TareasDAO>> snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    height: MediaQuery.of(context).size.height*0.18,
                    width: double.infinity,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(snapshot.data![index].fechaEnt!),
                          subtitle: Text(snapshot.data![index].dscTarea!),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/add', 
                                arguments: {
                                  'idTarea': snapshot.data![index].idTarea,
                                  'dscTarea':snapshot.data![index].dscTarea,
                                  'fecEnt':snapshot.data![index].fechaEnt,
                                }).then((value) {
                                  setState(() {});
                                });
                              }, 
                              icon: Icon(Icons.edit)
                              ),
                            IconButton(
                              onPressed: (){
                                AlertDialog alert = AlertDialog(
                                  title: Text('Importante!'),
                                  content: Text('¿Desea eliminar esta tarea?'),
                                  actions: [
                                    TextButton(
                                      onPressed: (){
                                        print('Eliminado');
                                        _database!.eliminar(snapshot.data![index].idTarea!, 'tblTareas');
                                        Navigator.pop(context);
                                      }, 
                                      child: Text('Eliminar')
                                      ),
                                      TextButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      }, 
                                      child: Text('Cancelar')
                                      ),
                                  ],
                                );
                              showDialog(context: context, builder: (_) => alert);
                              }, 
                              icon: Icon(Icons.delete)
                              ),
                          ],
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red[100],
                      ),
                  );
                },
                itemCount: snapshot.data!.length,
              );
          } else {
            if(snapshot.hasError)
            return Center(child: Text('Hubo un error en la petición'),);
          }

          return Center(child: CircularProgressIndicator(),);
        }, 
        )
    );
  }
}