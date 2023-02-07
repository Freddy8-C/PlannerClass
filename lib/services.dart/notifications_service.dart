import 'package:app_ups/shared_preferences/preferences.dart';
import 'package:flutter/material.dart';

class NotificacionsService {

  static GlobalKey<ScaffoldMessengerState> messegerKey = new GlobalKey<ScaffoldMessengerState>();

  static showSnackBar( String message){
    if(Preferences.isDarkMode){
            final snackBar = 
    new SnackBar(
      content: 
        Text(message,style: TextStyle(color:Colors.black,fontSize: 20) ) 
     
      );
       messegerKey.currentState!.showSnackBar(snackBar);
    }
    else{
         final snackBar = 
    new SnackBar(
      content: 
        Text(message,style: TextStyle(color:Colors.white,fontSize: 20) ) 

      );
       messegerKey.currentState!.showSnackBar(snackBar);
    }


   

  }

}