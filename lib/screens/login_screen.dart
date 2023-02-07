import 'package:app_ups/providers/providers.dart';
import 'package:app_ups/services.dart/services.dart';
import 'package:app_ups/shared_preferences/preferences.dart';
import 'package:app_ups/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ui/input_decorations.dart';

class LoginScreen extends StatelessWidget {
   
  const LoginScreen({Key? key}) : super(key: key);
  
 
@override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: AuthBackgraound(
        //este widget sirve para hacer scroll si sus hijos sobrepasan el espacio
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250,), //para dar espacio
              CardContainer(
                child:Column(
                    children: [
                      SizedBox(height:10),
                      Text('Login',style: Theme.of(context).textTheme.headline4,),
                      SizedBox(height:30),
                      
                      ChangeNotifierProvider(
                        create: (context) => LoginFormProvider() ,
                        child:  _LoginForm(),
                      ),
                     


                    ],                  
                ),
              ),
               SizedBox(height:50),
                Text('Desarrollado por:',
                style: TextStyle(fontSize: 18,color: Colors.black87),), 
              SizedBox(height:50),
            ],
          ),
        )
      )
    );
  }



}


class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    //final profesorService = Provider.of<ProfesorService>(context);

    return Container(
      child: Form(
        key: loginForm.formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction, 
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(color: Colors.black),
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_sharp
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  = new RegExp(pattern);
                  return regExp.hasMatch(value ?? '') 
                  ? null
                  : 'El valor no es un correo'
                  ;
              },
            ),
            SizedBox(height: 30,),
             TextFormField(
              style: TextStyle(color: Colors.black),
              autocorrect: false,
              obscureText: true, //para que no se pueda ver la contraseña
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                 hintText: '******',
                labelText: 'Contraseña',
                prefixIcon: Icons.login_outlined
              ),
              onChanged: (value) => loginForm..password = value,
              validator: (value) {
                  return ( value !=null && value.length >=6) 
                  ? null
                  : 'La contraseña debe de ser 6 caracteres'
                  ;
              },
            ),
            SizedBox(height: 30,),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80,vertical: 15),
                child: 
                
                Text(
                loginForm.isLoading
                ? 'Espere'
                : 'Ingresar'
                , 
                style: TextStyle(color: Colors.white)
                ,
                ),
              ),
              onPressed: loginForm.isLoading ? null :() async {
                FocusScope.of(context).unfocus();//quitar el teclado
                 final authService = Provider.of<AuthService>(context,listen: false);
                  if(!loginForm.isValidForm()) return;
                  loginForm.isLoading = true;
                  //se comapra con null el onpresse ya que se bloquea en nulo un boton
                  
                  final String? errorMessage =await authService.login(loginForm.email, loginForm.password);
                  if( errorMessage == null){
                      Navigator.pushReplacementNamed(context, 'home');
                      Preferences.correo=loginForm.email;
                      final profesorService = Provider.of<ProfesorService>(context,listen: false);
                      profesorService.loadProfesor(Preferences.correo);
                  }
                  else{
                    //TOdo hacer alert 
                     //print(errorMessage);
                     NotificacionsService.showSnackBar("Credenciales incorrectas");
                     loginForm.isLoading =false;
                  }
            },)
          ],
        )
        ),
    );
  }
}