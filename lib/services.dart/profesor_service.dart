
import 'dart:convert';

import 'package:app_ups/models/profesores.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';


class ProfesorService extends ChangeNotifier{
  final String _baseUrl = 'appups-f2c56-default-rtdb.firebaseio.com';
  
  bool isLoading = true;
  bool isSaving =false;
  File? newPictureFile;
  Profesor profesor = Profesor();
  List<Materia> materias = [];
  String? carrera;
  String? malla;
  String? lab;
  String? hInicio;
  String? hFin;
  String? estudiantes;
  String? equipos;
  List <String>? listTemas = [];
  String? tema="";
  String? objetivo="";
 
  ProfesorService(String correo) {
    
    this.loadProfesor(correo);
  }

  

  getTemaObjetivo(String unidad,String materia){
    for (var item in materias) {
        if(item.materia == materia){
         
             if(unidad == "Unidad 1"){
              tema = item.temas.unidad1.tema;
              objetivo = item.temas.unidad1.objetivos;
    }
    else if(unidad == "Unidad 2"){
         tema = item.temas.unidad2.tema;
              objetivo = item.temas.unidad2.objetivos;
    }
    else if(unidad == "Unidad 3"){
         tema = item.temas.unidad3.tema;
              objetivo = item.temas.unidad3.objetivos;
    }

    else if(unidad == "Unidad 4"){
         tema = item.temas.unidad4.tema;
              objetivo = item.temas.unidad4.objetivos;
    } 
        }
      }
   

  }

   getCarrera(String materia){
    listTemas = [];
    
    for (var item in materias) {
        if(item.materia == materia){
            carrera = item.carrera.toString();
            malla = item.malla.toString();
            lab = item.laboratorio.toString();
            hInicio = item.horaIni.toString();
            hFin = item.horaFin.toString();
            estudiantes = item.alumnos.toString();
            equipos = item.alumnos.toString();
            tema="";
            objetivo="";
             if(item.temas.unidad1.tema !=""){
              listTemas!.add("Unidad 1");
             
            }
            if(item.temas.unidad2.tema !=""){
              listTemas!.add("Unidad 2");
             
            }
             if(item.temas.unidad3.tema !=""){
              listTemas!.add("Unidad 3");
             
            }
             if(item.temas.unidad3.tema!=""){
              listTemas!.add("Unidad 4");
             
            }
            break;
        }
    }
  }




  List<String> getListCarreras(){
      List<String> listaCarrera = [];
      for (var carrera in materias) {
         listaCarrera.add(carrera.materia);
       
      }
      return listaCarrera;
  }

   List<String> getListTemas(){
      List<String> listaCarrera = [];
      for (var carrera in materias) {
         listaCarrera.add(carrera.materia);
       
      }
      return listaCarrera;
  }

 Future getListMateria( Jueves dia) async{
        final  Map<String, dynamic> materiasMap = jsonDecode(dia.toRawJson());
        materias = [];
        materiasMap.forEach((key, value) {
        var encodedString = jsonEncode(value) ;
        Map<String, dynamic>  valueMap = json.decode(encodedString);
        Materias materia  = Materias.fromJson(valueMap);
        if( materia.materia1.alumnos != 0 ){
           materias.add(materia.materia1);
        }
        if( materia.materia2.alumnos != 0 ){
            materias.add(materia.materia2);
        }
         if( materia.materia3.alumnos != 0 ){
             materias.add(materia.materia3);
        }
      });

      print(materias.length);
  }

  Future getDia() async{
    print("Metodo getDia");
    final now = DateTime.now();
    //var dia = now.weekday;
    var dia =2;
    print(dia);
    if(dia == 1){
      Jueves dia = Jueves(materias: profesor.dias!.lunes.materias);
      getListMateria(dia);
     
    }
    else if(dia == 2){
      Jueves dia = Jueves(materias: profesor.dias!.martes.materias);
      getListMateria(dia);
    }
     else if(dia == 3){
       Jueves dia = Jueves(materias: profesor.dias!.miercoles.materias);
       getListMateria(dia);
       
       
    }
     else if(dia == 4){
        Jueves dia = Jueves(materias: profesor.dias!.jueves.materias);
         getListMateria(dia);
    }
     else if(dia == 5){
       Jueves dia = Jueves(materias: profesor.dias!.viernes.materias);
        getListMateria(dia);
    }
    
  }

  Future loadProfesor(String correo) async{
    
      String correoClear = correo.replaceAll("@","");
      correoClear = correoClear.replaceAll(".", "");
      isLoading=true;
      //notifyListeners();
      final url = Uri.https(_baseUrl,'persona/${correoClear}.json');
      //final url = Uri.https(_baseUrl,'persona.json');
      final resp = await http.get(url);
      //obteniendo el string y convirtiendo a json
      //final Map<String,dynamic> profesoresMap = json.decode(resp.body);
      //aqui ya tengo los datos de adentro del profesor json
      profesor = Profesor.fromRawJson(resp.body);
      getDia();
      isLoading=false;
      notifyListeners();
    
  }

  Future saveRegistro( Map<String, dynamic> registro) async{
     
     final url = Uri.https(_baseUrl,'registros.json');
     final resp = await http.post(url,body: jsonEncode(registro));
     final decodedData = resp.body;
     print(decodedData);
  }

  Future updateProfesor(String correo,String imagen) async{
   
     String correoClear = correo.replaceAll("@","");
     correoClear = correoClear.replaceAll(".", "");
     isSaving=true;
     notifyListeners();
     profesor.imagen =imagen;
     final url = Uri.https(_baseUrl,'persona/${correoClear}.json');
    
     var encodedString = jsonEncode(profesor.toMap());
     Map<String, dynamic>  valueMap= json.decode(encodedString);
    
     
     final resp = await http.put(url,body: json.encode(valueMap));
     final decodedData = resp.body;

    final urlGet = Uri.https(_baseUrl,'persona/${correoClear}.json');
    final respGet = await http.get(urlGet);
    profesor = Profesor.fromRawJson(respGet.body);
    isSaving=false;
    notifyListeners();
  }



  Future<String?> uploadImage(path) async{
    this.newPictureFile = File.fromUri(Uri(path: path));
    if(this.newPictureFile == null) return null;
   
    notifyListeners();
    final url = Uri.parse("https://api.cloudinary.com/v1_1/dsayn9vmk/image/upload?upload_preset=j1qwykpr");
    final imageUploapRequest = http.MultipartRequest(
      'POST',url
    );
    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);
    imageUploapRequest.files.add(file);
    final streamResponse = await imageUploapRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if( resp.statusCode != 200 && resp.statusCode != 201){
      print("Salio mal");
      return null;
    }
    this.newPictureFile = null;
    final decodate = json.decode(resp.body);
    isSaving=false;
    return decodate["secure_url"];
   
  }

}