import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pm2022/provider/theme_provider.dart';
import 'package:pm2022/screens/about_us_screen.dart';
import 'package:pm2022/screens/dashboard_screen.dart';
import 'package:pm2022/screens/home.dart';
import 'package:pm2022/screens/list_popular_screen.dart';
import 'package:pm2022/screens/list_task_screen.dart';
import 'package:pm2022/screens/main_screen.dart';
import 'package:pm2022/screens/onboarding_screen.dart';
import 'package:pm2022/screens/popular_detail_screen.dart';
import 'package:pm2022/screens/profile_edit.dart';
import 'package:pm2022/screens/sign_up_screen.dart';
import 'package:pm2022/screens/splash_screen.dart';
import 'package:pm2022/screens/login_screen.dart';
import 'package:pm2022/screens/task_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool? dia, noche, calido;
    Future<void> getTema() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dia = prefs.getBool('dia');
      noche = prefs.getBool('noche');
      calido = prefs.getBool('calido');

      print('dia es $dia, noche es $noche, calido es $calido');
    }

    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: PMSNApp(),
    );
  }
}

class PMSNApp extends StatelessWidget {
  const PMSNApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeProvider tema = Provider.of<ThemeProvider>(context);

    return MaterialApp(
        title: 'Flutter Demo',
        theme: tema.getthemedata(),
        home: const SplashScreen(),
        routes: {
          '/dash': (BuildContext context) => DashboardScreen(),
          '/login': (BuildContext context) => LoginScreen(),
          '/task': (BuildContext context) => ListTaskScreen(),
          '/add': (BuildContext context) => TaskScreen(),
          '/popular': (BuildContext context) => ListPopularScreen(),
          '/profile': (BuildContext context) => ProfileEdit(),
          '/detail': (BuildContext context) => PopularDetailScreen(),
          '/about': (BuildContext context) => AboutUsScreen(),
          '/home': (BuildContext context) => HomePage(),
          '/onboarding': (BuildContext context) => OnBoardingScreen(),
          '/mainscreen': (BuildContext context) => MainScreen(),
          '/perfil': (BuildContext context) => HeroScreen(),
          '/signup': (BuildContext context) => SignUpScreen(),
        },
      );
  }
}


























