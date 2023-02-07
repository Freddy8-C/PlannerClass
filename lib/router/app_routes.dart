import 'package:app_ups/models/models.dart';
import 'package:flutter/material.dart';
import 'package:app_ups/screens/screens.dart';
class AppRoutes{
  static const initialRoute = 'checking';
  static const homeRoute = 'home';
  static const settingsRoute = 'settings';
  static final menuOptions = <MenuOption> [
      MenuOption(route: 'home', nameRoute: 'Home Screen', screen: HomeScreen()),
      MenuOption(route: 'login', nameRoute: 'Login Screen', screen: LoginScreen()),
      MenuOption(route: 'checking', nameRoute: 'Checking Screen', screen: CheckAuthScreen()),
      MenuOption(route: 'settings', nameRoute: 'Settings Screen', screen: SettingsScreen()),
      
  ];
    static Map<String, Widget Function(BuildContext)> getAppRoutes(){
      Map<String,Widget Function(BuildContext)> appRoutes ={};
      for (final option in menuOptions) {
          appRoutes.addAll({option.route :( BuildContext context ) => option.screen});
      }
      return appRoutes;
    }


  }
