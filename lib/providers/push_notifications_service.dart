import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


//SHA 1 F6:03:B9:11:5D:60:BD:00:0E:B2:CC:8A:82:D8:CB:59:9D:82:49:1C

class PushNotificationService{
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;


  static Future _backgroundHandler (RemoteMessage message) async{
    print("background Handler ${message.messageId}");
  }
  static Future _onMessageHandler (RemoteMessage message) async{
    print("_onMessageHandler ${message.messageId}");
  }
  static Future _onOpenMessageHandler (RemoteMessage message) async{
    print("_onOpenMessageHandler ${message.messageId}");
  }

  static Future initilizeApp() async{
    //Push Notificaciones

    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print("TOKEN DEL DISPOSITVO $token");

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpenMessageHandler );

    //Local Notificaciones
  }
}