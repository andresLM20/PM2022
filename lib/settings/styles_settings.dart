import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveTema(int opc) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (opc == 1) {
    print('EN EL SETTING ELIIGO DIAN');
    await prefs.setBool('dia', true);
    await prefs.setBool('noche', false);
    await prefs.setBool('calido', false);
  } else if (opc == 2) {
    print('EN EL SETTING ELIIGO NOCHE');
    await prefs.setBool('dia', false);
    await prefs.setBool('noche', true);
    await prefs.setBool('calido', false);
  } else if (opc == 3) {
    print('EN EL SETTING ELIIGO CALIDO');
    await prefs.setBool('dia', false);
    await prefs.setBool('noche', false);
    await prefs.setBool('calido', true);
  }
  print('ESTA HACIENDO EL CAMBIO EN EL TEMA');
}

Future<void> getTema() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? dia = prefs.getBool('dia');
  bool? noche = prefs.getBool('noche');
  bool? calido = prefs.getBool('calido');

  print(' obtiene en el style dia es $dia, noche es $noche, calido es $calido');
}

ThemeData temaDia(){
  final ThemeData base = ThemeData.light();
  saveTema(1);
  return base.copyWith(
    backgroundColor: Colors.red, 
  );
}

ThemeData temaNoche(){
  final ThemeData base = ThemeData.dark();
  saveTema(2).then((value) => getTema());
  return base.copyWith(
    backgroundColor: Color.fromARGB(255, 75, 17, 5), 
  );
}

ThemeData temaCalido(){
  final ThemeData base = ThemeData.light();
    saveTema(3).then((value) => getTema());
  return base.copyWith(
    backgroundColor: Color.fromARGB(255, 231, 146, 26), 
  );
}