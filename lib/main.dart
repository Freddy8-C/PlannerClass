
import 'package:app_ups/providers/providers.dart';
import 'package:app_ups/providers/push_notifications_service.dart';
import 'package:app_ups/router/app_routes.dart';
import 'package:app_ups/services.dart/services.dart';
import 'package:app_ups/shared_preferences/preferences.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  await PushNotificationService.initilizeApp();
  runApp(const AppState());
} 
//para cargar los providers es importante
class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => ThemeProvider(isDarkMode: Preferences.isDarkMode)),
        ChangeNotifierProvider(create: (context) => ProfesorService(Preferences.correo)),
        ChangeNotifierProvider(create: (context) => RegistroFormProvider())
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Docentes App',
      initialRoute: AppRoutes.initialRoute,
      scaffoldMessengerKey: NotificacionsService.messegerKey,
      routes: AppRoutes.getAppRoutes(),
      theme: Provider.of<ThemeProvider>(context).currenTheme
    );
  }
}