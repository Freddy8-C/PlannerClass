import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{
   //referencia al formulario
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();


  String email ='';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading (bool value ){
    _isLoading = value;
    notifyListeners();
  } 

  bool isValidForm(){
    //referencia al formulario
    print(formkey.currentState?.validate());
    print(email);
    print(password);
    return formkey.currentState?.validate() ?? false;
  }
  
}