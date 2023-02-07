import 'dart:convert';

import 'package:app_ups/shared_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier{
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyAdkMsdxhTDobSmbMCphao70UONVmCPZzU';

  final storage = new FlutterSecureStorage();
 

  // si retornamos algo es un error
  Future <String?> createUser( String email,String password) async{
      Preferences.correo = email;
      final Map<String,dynamic> authData = {
        'email':email,
        'password':password,
        'returnSecureToken':true
      };

      final url = Uri.https(_baseUrl,'/v1/accounts:signUp',{
        'key':_firebaseToken
      });

      //aqui dispara la peticion hhtp
      final resp = await http.post(url,body: json.encode(authData));

      //decodifica la respuesta 
      final Map<String,dynamic> decodeResp = json.decode(resp.body);

      if(decodeResp.containsKey('idToken')){
        //token hay que guardar en un lugar seguro
        await storage.write(key: 'token', value: decodeResp['idToken']);
        return null;
      }else{
        return decodeResp['error']['message'];
      }

      print(decodeResp);


  }


  Future <String?> login( String email,String password) async{
      Preferences.correo = email;
      final Map<String,dynamic> authData = {
        'email':email,
        'password':password,
        'returnSecureToken':true
      };

      final url = Uri.https(_baseUrl,'/v1/accounts:signInWithPassword',{
        'key':_firebaseToken
      });

      //aqui dispara la peticion hhtp
      final resp = await http.post(url,body: json.encode(authData));

      //decodifica la respuesta 
      final Map<String,dynamic> decodeResp = json.decode(resp.body);

      if(decodeResp.containsKey('idToken')){
        //token hay que guardar en un lugar seguro
        await storage.write(key: 'token', value: decodeResp['idToken']);
        await storage.write(key: 'correo', value: Preferences.correo);
        return null;
      }else{
        return decodeResp['error']['message'];
      }
  }

  Future logout() async{
    await storage.delete(key: 'token');
    await storage.delete(key: 'correo');
    return;
  }

  Future <String> readToken() async{
    Preferences.correo= await storage.read(key: 'correo') ?? '';
    return await storage.read(key: 'token') ?? '';
  }
}