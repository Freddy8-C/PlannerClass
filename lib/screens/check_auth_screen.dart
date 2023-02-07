import 'package:app_ups/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services.dart/services.dart';


class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context,listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if(!snapshot.hasData)
            return Text('');
            print(snapshot.data);
            if(snapshot.data == ''){
               Future.microtask(() {
              //para enviar rapido a las paginas otra forma de hacer
              Navigator.pushReplacement(context,PageRouteBuilder(
                pageBuilder: (_,__,___)=> LoginScreen(),
                transitionDuration: Duration(seconds: 0)
                    )
                );
           });
            }
            else{
               Future.microtask(() {
              //para enviar rapido a las paginas otra forma de hacer
              Navigator.pushReplacement(context,PageRouteBuilder(
                pageBuilder: (_,__,___)=> HomeScreen(),
                transitionDuration: Duration(seconds: 0)
                    )
                );
              
              
           });
            }
            //esto sirve para que termine la construccion de la pantalla
            //eh de forma inmediata realice lo que esta del microtask
          
           return Container();
          },
        )
        ),
    );
  }
}