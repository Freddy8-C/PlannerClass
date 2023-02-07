import 'package:app_ups/shared_preferences/preferences.dart';
import 'package:flutter/material.dart';
class ThemeProvider extends ChangeNotifier{

  ThemeData currenTheme;
  String? correo;

  ThemeProvider({
    required bool isDarkMode
    
  }
  ) : currenTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();

  setLigthMode(){
    currenTheme = ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300]
    );
    notifyListeners();
  }

   setDarkMode(){
    currenTheme = ThemeData.dark();
    notifyListeners();
  }

}