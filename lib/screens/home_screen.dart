import 'package:app_ups/services.dart/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:app_ups/shared_preferences/preferences.dart';

import '../providers/providers.dart';
import '../providers/push_notifications_service.dart';
import '../ui/input_decorations.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    final profesorService = Provider.of<ProfesorService>(context);
    final registroForm = Provider.of<RegistroFormProvider>(context);  
    String url =profesorService.profesor.imagen.toString();
    print("URL");
    print(url);
    if( profesorService.isLoading){
      profesorService.loadProfesor(Preferences.correo);
      return 
          Scaffold(
              body: Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              ),
          );
    }
    else{
    
       return 
     _Formulario(url: url, registroForm: registroForm, profesorService: profesorService);
    }
   
  }
}

class _Formulario extends StatelessWidget {
  const _Formulario({
    Key? key,
    required this.url,
    required this.registroForm,
    required this.profesorService,
  }) : super(key: key);

  final String url;
  final RegistroFormProvider registroForm;
  final ProfesorService profesorService;


  @override
  Widget build(BuildContext context) {
    //profesorService.getCarrera(profesorService.materias[0].materia);
   
    
    return Scaffold(
     appBar: AppBar(
       title: Text("${Preferences.correo}"),
       actions: [
         Container(
           margin: EdgeInsets.only(right: 5),
           child: url == null
                   ?CircleAvatar(
                  
                   child: Text("U",style: TextStyle(
                    
                     color: Colors.white
                   ),),
                   backgroundColor: Colors.indigo[900],
                 )
                   : CircleAvatar(
                  
                   backgroundImage: NetworkImage(url),
                   backgroundColor: Colors.indigo[900],
                 ),
         )
       ],
     
       ),
       
     body: 
     SingleChildScrollView(
       child: Container(
         padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
         
         child: 
         Form(
           key: registroForm.formKey,
           autovalidateMode: AutovalidateMode.onUserInteraction,
           child: Column(children: [


              DropdownButton(
                isExpanded: true,
                items: profesorService.getListCarreras().map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(

               value: value,
               child: Text(value),
             );
           }).toList(), 
                hint: Text("Seleccione la materia"),
                onChanged: (value) {
                    registroForm.materia = value;
                    registroForm.tema="";
                    registroForm.objetivo="";
                    registroForm.llenarValores(profesorService);
                },),

                DropdownButton(
                items: registroForm.listTemas!.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(

               value: value,
               child: Text(value),
             );
           }).toList(), 
           isExpanded: true,
                hint: Text("Seleccione a unidad"),
                onChanged: (value) {
                  print(value);
                   registroForm.llenarTemasObjetivos(profesorService, value!);
                },),
                 SwitchListTile.adaptive(
                  
                  value: registroForm.active!, 
                  title: Text("Actividad extracurricular",style: TextStyle(
                    fontSize: 20
                  ),),
                  onChanged: (value) {
                        registroForm.artividitiExtra(value);
                    },
                ),
              
              
              SizedBox(height: 10,),
              Text(registroForm.materia!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
               _CardText(registroForm: registroForm),
               TextFormField(
                  controller: TextEditingController(text:registroForm.estudiantes),
                  keyboardType: TextInputType.number,
                  inputFormatters:  [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), 
                    FilteringTextInputFormatter.digitsOnly
                  ],
                   decoration: InputDecorations.authInputDecoration(
                   hintText: 'Número de estudiantes',
                   labelText: 'Número de estudiantes presentes',
                   prefixIcon: Icons.person_add_alt
                 ),
                 onChanged: (value) {
                    registroForm.estudiantes = value;
                 },
               ),
              SizedBox(height: 10,),
               TextFormField(
                  controller: TextEditingController(text:registroForm.estudiantes),
                  keyboardType: TextInputType.number,
                  inputFormatters:  [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), 
                    FilteringTextInputFormatter.digitsOnly
                  ],
                   decoration: InputDecorations.authInputDecoration(
                   hintText: 'Número de equipos usados',
                   labelText: 'Número de equipos usados',
                   prefixIcon: Icons.computer_outlined
                 ),
                 onChanged: (value) {
                    registroForm.equipos = value;
                 },
               ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Text(
                      "Carrera: ",style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                     SizedBox(width: 5,),
                      Text(
                      "${registroForm.carrera}",style: TextStyle(
                        fontSize: 25,
     
                      ),
                    ),
     
                    
                  ],
                ),
              ),
              SizedBox(height: 10,),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Text(
                      "Malla: ",style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                     SizedBox(width: 5,),
                      Text(
                      "${registroForm.malla}",style: TextStyle(
                        fontSize: 25,
     
                      ),
                    ),
                  ],
                ),
              ),
               SizedBox(height: 10,),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Text(
                      "Laboratorio:",style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                     SizedBox(width: 5,),
                      Text(
                      "${registroForm.lab}",style: TextStyle(
                        fontSize: 25,
     
                      ),
                    ),
                  ],
                ),
              ),
     
                SizedBox(height: 10,),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Text(
                      "Inicio:",style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                     SizedBox(width: 5,),
                      Text(
                      "${registroForm.hInicio}:00",style: TextStyle(
                        fontSize: 25,
     
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      "Fin:",style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                     SizedBox(width: 5,),
                      Text(
                      "${registroForm.hFin}:00",style: TextStyle(
                        fontSize: 25,
     
                      ),
                    ),
                  ],
                ),
              ),
            
           ],),
         ),
       ),
     ),
     drawer: Drawer(child: SideMenu(),),
     floatingActionButton: FloatingActionButton(
       onPressed: () {
        String correoClear =Preferences.correo.replaceAll("@","");
        correoClear = correoClear.replaceAll(".", "");
          
          Map<String, dynamic> registro= {
             "actividad":registroForm.actividad,
             "carrera":registroForm.carrera,
             "correo":correoClear,
             "equipos":registroForm.equipos,
             "estudiantes":registroForm.estudiantes,
             "fin":registroForm.hFin,
             "inicio":registroForm.hInicio,
             "laboratorio":registroForm.lab,
             "malla":registroForm.malla,
             "objetivo":registroForm.objetivo,
             "tema":registroForm.tema,
             "fecha":DateTime.now().day.toString()+"-"+DateTime.now().month.toString()+"-"+DateTime.now().year.toString(),
             "hora":DateTime.now().hour.toString()+":"+DateTime.now().minute.toString()
          };

          profesorService.saveRegistro(registro);
          NotificacionsService.showSnackBar("Registro exitoso");
       },
       child: Icon(Icons.send_and_archive_rounded),
     ),
    );
  }


}

class _CardText extends StatelessWidget {
  const _CardText({
    Key? key,
    required this.registroForm,
  }) : super(key: key);

  final RegistroFormProvider registroForm;

  @override
  Widget build(BuildContext context) {
     if(registroForm.active!){
        return
         
              TextFormField(
              style: TextStyle(),
              autocorrect: false,
              
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                 hintText: 'Ingrese su actividad',
                labelText: 'Actividad',
                prefixIcon: Icons.local_activity
              ),
              onChanged: (value) => registroForm.actividad = value,
            );
     }
     else{
      return Column(
      children: [
       
        SizedBox(height: 10),
        Text(registroForm.tema!,maxLines: 3,),
        SizedBox(height: 10,),
        Text(registroForm.objetivo!,maxLines: 3,textAlign: TextAlign.justify),
      ],
    );
     }

  }
}
