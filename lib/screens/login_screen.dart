import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController txtConUser = TextEditingController();
  TextEditingController txtConPwd = TextEditingController();
  bool? _checkBox = false;
  Future<void> sesionActive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ban', true);
    Navigator.pushNamed(context, '/dash');
    txtConUser.clear();
    txtConPwd.clear();
    _checkBox = false;
  }

  bool? ban;

  /* Future<void> sesionCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ban = await prefs.getBool('ban');

    print('El valor de la bandera es $ban');
    if (ban == true) {
      Navigator.pushNamed(context, '/dash');
    }
  } */
  
  @override
  Widget build(BuildContext context) {
    final txtUser = TextField(
      controller: txtConUser,
      decoration: InputDecoration(
          hintText: 'Introduce el usuario', label: Text('Correo electronico')),
      //onChanged: (value) {},
    );
    final txtPwd = TextField(
      controller: txtConPwd,
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Introduce la contraseña', label: Text('Contraseña')),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/fondo login.png'), fit: BoxFit.cover)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.width / 5,
              child: Image.asset(
                'assets/logoitc.png', 
                width: MediaQuery.of(context).size.width / 1.5,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 20,
                  right: MediaQuery.of(context).size.width / 20,
                  bottom: MediaQuery.of(context).size.width / 20),
              color: Colors.white,
              child: ListView(
                shrinkWrap: true,
                children: [
                  txtUser,
                  SizedBox(
                    height: 5,
                  ),
                  txtPwd,
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: _checkBox,
                          onChanged: (value) {
                            setState(() {
                              _checkBox = value;
                            });
                          }),
                      Text('Recordar inicio de sesión.'),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width /2, 
              child: GestureDetector(
                onTap: () {
                  print('Valor de la caja ${txtConUser.text}');
                  if ((txtConPwd.text.isNotEmpty) &&
                      (txtConUser.text.isNotEmpty)) {
                    if ((txtConUser.text == 'logan') &&
                        (txtConPwd.text == '1234')) {
                      if ((_checkBox == true)) {
                        sesionActive();
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Active el checkbox'),
                              );
                            });
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text('ERROR INICIO SESIÓN'),
                                content: SingleChildScrollView(
                                  child: ListBody(children: [
                                    Text(
                                        'El usuario o la contraseña que se está ingresando es incorrecto'),
                                  ]),
                                ));
                          });
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text('ERROR INICIO SESIÓN'),
                              content: SingleChildScrollView(
                                child: ListBody(children: [
                                  Text(
                                      'Los campos de usuario y contraseña no deben estar vacios para continuar'),
                                ]),
                              ));
                        });
                  }
                },
                child: Image.asset(
                  'assets/login.png',
                  height: MediaQuery.of(context).size.width / 6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
