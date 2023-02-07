import 'package:flutter/material.dart';

import '../services.dart/services.dart';

class RegistroFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String? materia="";
  String? carrera="";
  String? malla="";
  String? lab="";
  String? hInicio="00";
  String? hFin="00";
  String? estudiantes="";
  String? equipos="";
  List <String>? listTemas = [];
  String? tema = "";
  String? objetivo = "";
  bool? active = false;
  String? actividad ="";
  //Aqui debo tener una isntancia del modelo que voy a enviar.

  //aqui tengo q mandar por constructor el que voy a mandar
  RegistroFormProvider(){

  }


  llenarValores(ProfesorService profesorService) {
    listTemas = [];
    profesorService.getCarrera(materia!);
    estudiantes = profesorService.estudiantes;
    equipos= profesorService.equipos;
    carrera = profesorService.carrera;
    malla = profesorService.malla;
    lab = profesorService.lab;
    hInicio = profesorService.hInicio;
    hFin = profesorService.hFin;
    listTemas = profesorService.listTemas;
   
    notifyListeners();
  
}

llenarTemasObjetivos(ProfesorService profesorService,String unidad){
    profesorService.getTemaObjetivo(unidad, materia!);
    active=false;
    tema = profesorService.tema;
    objetivo = profesorService.objetivo;
    notifyListeners();
}

 artividitiExtra(bool value){
   tema = "";
   objetivo = "";
   active = value;
   notifyListeners();
 }

   

}