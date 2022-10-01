import 'package:flutter/material.dart';
import 'package:pm2022/settings/styles_settings.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData = temaDia();
  //double _dimenFont = 1;

  //getdimeFont() => this._dimenFont;
  //setdimenFont(double value){
  //  this._dimenFont = value;
  //  notifyListeners();
  //}

  getthemedata() => this._themeData;
  setthemedata(ThemeData theme){
    this._themeData = theme;
    notifyListeners();
  }
}