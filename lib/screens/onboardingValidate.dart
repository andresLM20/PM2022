import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingValidate extends StatelessWidget {
  const OnBoardingValidate({Key? key}) : super(key: key);

  Future<void> sesionCheck(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //SharedPreferences On boarding
    bool? showHome = await prefs.getBool('showHome');
    if (showHome == false) {
      Navigator.pushNamed(context, '/onboarding');
    } else {
      Navigator.pushNamed(context, '/mainscreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    sesionCheck(context);
    return Container();
  }
}
