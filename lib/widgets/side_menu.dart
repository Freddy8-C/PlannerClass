import 'package:app_ups/services.dart/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});
  
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context,listen:false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _DrawerHeader(),
         
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: Text('Home'),
            onTap: () {
                Navigator.pushReplacementNamed(context,'home');
            },

          ),
          Divider(color: Colors.grey,height: 1,),
            ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: Text('Configuración'),
            onTap: () {
                  Navigator.pushReplacementNamed(context,'settings');
            },
          ),
          Divider(color: Colors.grey,height: 1,),
            ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: Text('Log out'),
            onTap: () {
                 authService.logout();
                 Navigator.pushReplacementNamed(context,'login');
            },
          ),
          Divider(color: Colors.grey,height: 1,),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child:Container(),
      decoration: BoxDecoration(
         image: DecorationImage(
          image:AssetImage('assets/cabeceraUps.jpg') ,
          fit: BoxFit.cover
          )
      ),
    );
  }
}