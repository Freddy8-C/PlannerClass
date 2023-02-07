import 'package:shared_preferences/shared_preferences.dart';

import '../providers/push_notifications_service.dart';

class Preferences {
    static late SharedPreferences _prefs ; //late , significa que cuando la voy a tulizar ya esta inicializada

    static String _name = '';
    static bool _isDarkmode = false;
    static String _correo ="";

    static String get correo{
      return _prefs.getString('correo') ?? _correo;
    }

    static set correo(String correo){
        _correo= correo;
        _prefs.setString('correo', correo);
    }

    static Future init()async{
      _prefs = await SharedPreferences.getInstance();
     
    }

    static String get name{
      return _prefs.getString('name') ?? _name;
    }

    static set name(String name){
        _name = name;
        _prefs.setString('name', name);
    }


    static bool get isDarkMode{
      return _prefs.getBool('isDarkMode') ?? _isDarkmode;
    }

    static set isDarkMode(bool isDarkMode){
        _isDarkmode = isDarkMode;
        _prefs.setBool('isDarkMode', isDarkMode);
       

    }



}