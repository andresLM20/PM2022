import 'package:flutter/material.dart';
import 'package:pm2022/screens/counter_screen.dart';
import 'package:pm2022/screens/main_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: MainScreen(),
      duration: 2000,
      imageSize: 130,
      imageSrc: "assets/logoitc.png",
      text: "Bienvenido",
      textType: TextType.ScaleAnimatedText,
      textStyle: TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: Colors.white,
    );
  }
}
