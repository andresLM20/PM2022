import 'package:flutter/material.dart';
import 'package:pm2022/provider/theme_provider.dart';
import 'package:pm2022/screens/counter_screen.dart';
import 'package:pm2022/screens/main_screen.dart';
import 'package:pm2022/screens/onboardingValidate.dart';
import 'package:pm2022/screens/onboarding_screen.dart';
import 'package:pm2022/settings/styles_settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'globals.dart' as globals;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //setTema();
    //setTema();
  }

  bool? dia, noche, calido;
  Future<String?> getTema() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dia = prefs.getBool('dia');
    noche = prefs.getBool('noche');
    calido = prefs.getBool('calido');
    if (dia == true) return 'dia';
    if (noche == true) return 'noche';
    if (calido == true) return 'calido';
    print(' es el splash dia es $dia, noche es $noche, calido es $calido');
  }

  setTema() {
    ThemeProvider tema = Provider.of<ThemeProvider>(context);
    print('imaginemo que entra a seleccionar el data en el spplash');
    getTema().then((value) {
      if (value == 'noche') return tema.setthemedata(temaNoche());
      if (value == 'calido') return tema.setthemedata(temaCalido());
      return tema.setthemedata(temaDia());
    });
    print(' en el setTema  dia es $dia, noche es $noche, calido es $calido');
    //if (dia == true) return temaDia();
  }
  var count = globals.countGlobal;
  @override
  Widget build(BuildContext context) {
    print('Valor del contador $count');
    if (count == 0) {
      print('Valor del contador dentro del if $count');
      globals.countGlobal = count++;
      setTema();
    }
    return SplashScreenView(
      navigateRoute: OnBoardingValidate(),
      duration: 2000,
      imageSize: 130,
      imageSrc: "assets/logoitc.png",
      text: "Bienvenido alumno",
      textType: TextType.ScaleAnimatedText,
      textStyle: TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: Colors.white,
    );
  }
}
