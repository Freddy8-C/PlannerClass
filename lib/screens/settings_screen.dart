import 'package:app_ups/providers/providers.dart';
import 'package:app_ups/services.dart/services.dart';
import 'package:app_ups/shared_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
   
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context,listen: false);
    final profesorService = Provider.of<ProfesorService>(context);
    String url =profesorService.profesor.imagen.toString();
    return  Scaffold(
      appBar: AppBar(
      title: Text("Configuración"),
       actions: [
          Container(
            margin: EdgeInsets.only(right: 5),
            child: profesorService.isSaving
                    ?CircularProgressIndicator(
                      color: Colors.red,
                      
                      )
                    : CircleAvatar(
                   
                    backgroundImage: NetworkImage(url),
                    backgroundColor: Colors.indigo[900],
                  ),
          )
        ],
      
      
      ),
      drawer: SideMenu(),
      body: Padding(
        
        padding: const EdgeInsets.all(8.0),
        
        child: SingleChildScrollView(
          child: Column(
            
            children: [
                SizedBox(height: 20,),
                Text('Tema',style: TextStyle(
                    fontSize: 30
                  )),
                Divider(),
                SwitchListTile.adaptive(
                  value: Preferences.isDarkMode, 
                  title: Text("Modo Nocturno",style: TextStyle(
                    fontSize: 20
                  ),),
                  onChanged: (value) {
                     Preferences.isDarkMode =value;
                     value ? themeProvider.setDarkMode() : themeProvider.setLigthMode();
                      setState(() {
                        
                      });
                    },
                ),
                Divider(),
                SizedBox(height: 50,),
                Center(
                  child:  profesorService.isSaving
                    ? CircularProgressIndicator(color: Colors.red,)
                    : CircleAvatar(
                    maxRadius: 100,
                    backgroundImage: 
                    
                    NetworkImage(url),
                    backgroundColor: Colors.indigo[900],
                  ),
                  
                  
                )

                
            ]),
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt_outlined),
        onPressed: () async {
            final picker = new ImagePicker();
            final XFile? pickedFile = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 100
                    );
              if(pickedFile == null){
                      print('No selecciono anda');
                        return;
                  }
            final String? imagaURl = await profesorService.uploadImage(pickedFile.path);
            if(imagaURl != null){
              await profesorService.updateProfesor(Preferences.correo,imagaURl);
            }
        },
      ),
    );
  }
}