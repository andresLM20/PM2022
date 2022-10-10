import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pm2022/database/database_helperP.dart';
import 'package:pm2022/models/perfil_model.dart';
import 'package:pm2022/provider/theme_provider.dart';
import 'package:pm2022/provider/theme_screen.dart';
import 'package:pm2022/screens/home.dart';
import 'package:pm2022/screens/login_screen.dart';
import 'package:pm2022/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pm2022/settings/styles_settings.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  File? image;
  Future<void> sesionClose(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? ban = prefs.getBool('ban');
    print('Este es el valor de ban en el dash $ban');
    await prefs.setBool('ban', false);
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return LoginScreen();
    }), (route) => route.isFirst);
  }

  DatabaseHelperP? _databaseHelper;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelperP();
  }

//TRAE LOS VAORES DEL USUSARIO DEL ID QUE SE TIENE
  var data,data2,data3;

  Future<void> getDatos(context) async {
    data = await _databaseHelper?.getFotoPath();
    print('ruta: '+data.first.imagen);
    if(data.first.imagen=='assets/cuphead.png')
      {image== null;}
    else
      {image = File(data.first.imagen);}
    data2 = await _databaseHelper?.getNombre();
    data3 = await _databaseHelper?.getCorreo();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
     Widget WidgetTheme(){ 
    return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Tema",style: TextStyle(fontWeight: FontWeight.bold)),
            TextButton.icon(
              onPressed: (){
                tema.setthemedata(temaDia());
              }, 
              icon: Icon(Icons.brightness_1, color: Colors.black,), 
              label: Text("")
            ),
            TextButton.icon(
              onPressed: (){
                tema.setthemedata(temaNoche());
              }, 
              icon: Icon(Icons.dark_mode, color: Colors.black,), 
              label: Text("")
            ),
            TextButton.icon(
              onPressed: (){
                tema.setthemedata(temaCalido());
              }, 
              icon: Icon(Icons.hot_tub_sharp, color: Colors.black,), 
              label: Text("")
            ),
          ],
        ),
      );
  }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: FutureBuilder(
        future: getDatos(context),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return Drawer(
            backgroundColor: Color.fromARGB(255, 255, 207, 51),
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/cup3.jpg'), //Portada
                            fit: BoxFit.cover)),
                    currentAccountPicture: GestureDetector(
                      onTap: () { 
                        Navigator.pushNamed(context, '/perfil',
                        arguments:{
                          'imagen':data.first.imagen,
                        }).then((value) => setState((){}));
                      },
                      child: Hero(
                        tag: 's2',
                        child: image == null 
                        ? CircleAvatar(
                          backgroundImage: AssetImage('assets/cuphead.png'),  //Perfil
                          backgroundColor: Color.fromARGB(255, 255, 207, 51),
                        ) : CircleAvatar(
                          backgroundImage: Image.file(image!).image,
                        ),
                      ),
                    ),
                    accountName: data2.first.nombre == null
                    ? Text(
                      'Andrés Morales Martínez',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                    : Text(
                      data2.first.nombre,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    accountEmail: data3.first.correo == null
                    ? Text('18030666@itcelaya.edu.mx') : Text(data3.first.correo),
                    ),
                WidgetTheme(),
                ListTile(
                  leading: Image.asset('assets/smartphone.png'),
                  trailing: Icon(Icons.chevron_right),
                  title: Text('Base de datos'),
                  onTap: () {
                    
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/smartphone.png'),
                  trailing: Icon(Icons.chevron_right),
                  title: Text('List Task'),
                  onTap: () {
                    Navigator.pushNamed(context, '/task');
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/smartphone.png'),
                  trailing: Icon(Icons.chevron_right),
                  title: Text('Popular Movies'),
                  onTap: () {
                    Navigator.pushNamed(context, '/popular');
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/smartphone.png'),
                  trailing: Icon(Icons.chevron_right),
                  title: Text('About Us'),
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/logout.png'),
                  trailing: Icon(Icons.chevron_right),
                  title: Text('Log Out'),
                  onTap: () {
                    sesionClose(context);
                  },
                ),
              ],
            ),
          );
        }
      ),
      body: HomePage(),
    );
  }
}

//FINAL DASHBOARD SCREEN 
//--------------------------------------------------------------------------------
//INICIO HERO SCREEN

class HeroScreen extends StatefulWidget {
  const HeroScreen({Key? key}) : super(key: key);

  @override
  State<HeroScreen> createState() => _HeroScreenState();
}

class _HeroScreenState extends State<HeroScreen> {
  DatabaseHelperP? _database;
  var data;
  var ruta;
  final double coverHeight = 280;
  final double profileHeight = 144;
  File? image;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _database=DatabaseHelperP();
    _database!.getPerfil();
  }

  Future setImage(op) async{
    var pickerFile;
     if (op == 1) {
      pickerFile = await _picker.pickImage(source: ImageSource.camera);
    } else {
      pickerFile = await _picker.pickImage(source: ImageSource.gallery);
    }
    if (pickerFile != null) {
      _database?.actualizarPerfil({
        'idperfil': 0,
        'imagen': pickerFile.path,
      }, 'tblperfil').then((value) => setState(() {
            print('Foto Actualizada');
          }));
      ruta = await _database?.getFotoPath();
    }
    setState(() {
      if (pickerFile != null && ruta != null) {
        image = File(ruta.first.imagen);
      }
    });
    Navigator.of(context).pop();
    final snackBar = SnackBar(content: Text('Foto actualizada'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<List<PerfilDAO>> setData(context) async{
    data=_database!.getPerfil();
    ruta = await _database?.getFotoPath();
    if(ruta.first.imagen=='assets/cuphead.png')
      {image== null;}
    else
      {image = File(ruta.first.imagen);}
    return data;
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final perfil = ModalRoute.of(context)!.settings.arguments as Map;
      //SI LA IMAGEN ES NULA ASIGNA IMAGEN NULA
      if (perfil['imagen'] == null) {
        image = null;
      }
    }
    return Scaffold(
      body: FutureBuilder(
        future: setData(context),
        builder: (context, AsyncSnapshot<List<PerfilDAO>> snapshot) {
              var res = _database!.getPerfil();
              print('nombre desde build'+(snapshot.data?[0].nombre).toString()); //works
              print('imagen desde build'+(snapshot.data?[0].imagen).toString()); //works
              String path = (snapshot.data?[0].imagen).toString();
              return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                buildTop(snapshot, path),
                buildContent(snapshot),
              ],
            );
        }
      ),
    );
  }

  Widget buildTop(AsyncSnapshot snapshot, String path){
    final bottom = profileHeight/2;
    final top = coverHeight - profileHeight/2;
    final top2 = 400 - profileHeight/2;
    print('path desde buildtop'+path); //works
    return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: bottom),
            child: buildCoverImage()
            ),
          Positioned(
            top: top,
            child: buildProfileImage(snapshot)
            ),
          Positioned(
            top: top2,
            child: buildButtonProfile(),
          )
        ],
      );
  }

  Widget buildButtonProfile() => Container(
    child: GestureDetector(
      onTap: () async => {
        showModalBottomSheet(
          context: context, 
          builder: (context) => Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width/30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Icon(
                    Icons.linear_scale_sharp
                  ),
                ),
                ListTile(
                  trailing: Icon(
                    Icons.camera_alt_rounded,
                    size: MediaQuery.of(context).size.height/30,
                  ),
                  title: Text('Cámara', style: TextStyle(fontSize: MediaQuery.of(context).size.height/40),),
                  onTap: (){setImage(1);},
                ),
                ListTile(
                  trailing: Icon(
                    Icons.image_rounded,
                    size: MediaQuery.of(context).size.height/30,
                  ),
                  title: Text('Galería', style: TextStyle(fontSize: MediaQuery.of(context).size.height/40),),
                  onTap: (){setImage(2);},
                ),
              ]
            ),
          )
        )
      },
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          backgroundColor: Colors.yellow,
          radius: 20,
          child: Center(
            child: Icon(FontAwesomeIcons.camera,size: 25,color:Color.fromARGB(255, 138, 136, 32)),          
          ),
        ),
      ),
    ),
  );

  Widget buildCoverImage() => Container(
    child: Image.network('https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/cd3e8e66-eda2-4f0d-be39-bc552489c1c4/ddyoev8-83bead08-4664-4818-b06a-0d4123ba15f6.jpg/v1/fill/w_1275,h_626,q_70,strp/cuphead___elder_kettle_s_indoor_house_background_by_berryviolet_ddyoev8-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NjI5IiwicGF0aCI6IlwvZlwvY2QzZThlNjYtZWRhMi00ZjBkLWJlMzktYmM1NTI0ODljMWM0XC9kZHlvZXY4LTgzYmVhZDA4LTQ2NjQtNDgxOC1iMDZhLTBkNDEyM2JhMTVmNi5qcGciLCJ3aWR0aCI6Ijw9MTI4MCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.MCMctYA9P6SHmjY30-XcQJOU6eKly4rnmSPY4U01kHU',
    width: double.infinity,
    height: coverHeight,
    fit: BoxFit.cover,
    ),
  );

  Widget buildProfileImage(AsyncSnapshot snapshot){ 
    return Hero(
      tag: 's2',
      child: CircleAvatar(
        radius: profileHeight/2 + 5,
        backgroundColor: Colors.white,
        child: image == null
        ? CircleAvatar(
          radius: profileHeight/2,
          backgroundImage: AssetImage('assets/cuphead.png')
        )
        : CircleAvatar(
          radius: profileHeight/2,
          backgroundImage: Image.file(image!).image,
        )
      ),
    );
  }

  Widget buildContent(AsyncSnapshot snapshot) => Column(
    children: [
      const SizedBox(height: 40),
      Text(
        (snapshot.data?[0].nombre).toString(),
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      const SizedBox(height: 8),
      Text(
        (snapshot.data?[0].correo).toString(),
        style: TextStyle(fontSize: 20, color: Colors.black54),
        ),
      const SizedBox(height: 8),
      Text(
        (snapshot.data?[0].telefono).toString(),
        style: TextStyle(fontSize: 20, color: Colors.black54),
        ),
      const SizedBox(height: 8),
      Text(
        (snapshot.data?[0].github).toString(), 
        style: TextStyle(fontSize: 20, color: Colors.black54),
        ),
        const SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _launchUrl('https://www.facebook.com/logands20'),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.yellow,
                child: Center(child: Icon(FontAwesomeIcons.facebook,size: 32,color:Color.fromARGB(255, 138, 136, 32)),),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => _launchUrl('https://github.com/andresLM20'),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.yellow,
                child: Center(child: Icon(FontAwesomeIcons.github,size: 32,color:Color.fromARGB(255, 138, 136, 32)),),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => _launchUrl('https://www.instagram.com/logan_ds20/'),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.yellow,
                child: Center(child: Icon(FontAwesomeIcons.instagram,size: 32,color:Color.fromARGB(255, 138, 136, 32)),),
              ),
            ),
            const SizedBox(width: 12),
            CircleAvatar(
              backgroundColor: Colors.yellow,
              radius: 25,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile', 
                                    arguments: {
                                      'idperfil': snapshot.data![0].idperfil,
                                      'nombre':snapshot.data![0].nombre,
                                      'correo':snapshot.data![0].correo,
                                      'telefono':snapshot.data![0].telefono,
                                      'github':snapshot.data![0].github,
                                    }).then((value) {
                                      setState(() {});
                                    });
                  }, 
                  icon: Icon(FontAwesomeIcons.penToSquare), iconSize: 28, color: Color.fromARGB(255, 138, 136, 32),
                ),
              ),
            ),
          ],
        )
    ]
  );

  _launchUrl(String url) async{
    await launch(url);
  }
}