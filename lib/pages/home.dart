import 'package:eval2_dsw22/pages/AcercaDe.dart';
import 'package:eval2_dsw22/pages/Consulta.dart';
import 'package:eval2_dsw22/pages/Registrar.dart';
import 'package:eval2_dsw22/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => homeState();
}

class homeState extends State<Home> {
  int ItemDrawer = 0;

  _getDrawerItem(int position) {
    switch (position) {
      case 0:
        return AcercaDe();
      case 1:
        return Registro();
      case 2:
        return Consulta();
       case 3:
        return LoginPage();
    }
  }

  void _onSelectItemDrawer(int pos) {
    Navigator.pop(context);
    setState(() {
      ItemDrawer = pos;
    });
  }
  

void _alertClose (){
  QuickAlert.show(
context: context,
type: QuickAlertType.confirm,
text: 'desea salir de esta  cuenta',
confirmBtnText: 'aceptar',
cancelBtnText: 'cancelar',
barrierDismissible: false,
cancelBtnTextStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
confirmBtnColor: Colors.green,
onConfirmBtnTap: () {
  FirebaseAuth.instance.signOut();
  Navigator.pushNamed(context, "/login");
},
onCancelBtnTap: (){
  Navigator.of(context).pop();

}, 
);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text('EVALUACIÓN 2'),
        actions: [
          IconButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, "/login");
              _alertClose();
              
            },
            icon: const Icon(Icons.close),
  
            )
        ],
      ),


      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[200],
              ),
              child: const Center(
                child: Text('NAVEGACIÓN',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    )),
              ),
            ),
            Divider(color: Colors.black),
            ListTile(
              leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('img/acercaDe.png',
                    width: 35,
                    height: 35,),
                  ),
              title: const Text('Acerca de nosotros',
              style: TextStyle(fontWeight: FontWeight.bold),),
              onTap: () {
                _onSelectItemDrawer(0);
              },
            ),
            ListTile(
                leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('img/registrar.png',
                    width: 35,
                    height: 35,),
                  ),
                title: const Text('Registrar productos',
              style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  _onSelectItemDrawer(1);
                }),
            ListTile(
                leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('img/consultar.png',
                    width: 35,
                    height: 35,),
                  ),
                title: const Text('Consultar productos',
              style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  _onSelectItemDrawer(2);
                }),
                 ListTile(
                title: const Text('login',
              style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  _onSelectItemDrawer(3);
                }),
            Divider(color: Colors.black),
          ],
        ),
      ),
      body: _getDrawerItem(ItemDrawer),
    );
  }
}
