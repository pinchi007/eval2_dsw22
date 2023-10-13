import 'package:eval2_dsw22/pages/AcercaDe.dart';
import 'package:eval2_dsw22/pages/Consulta.dart';
import 'package:eval2_dsw22/pages/Registrar.dart';
import 'package:eval2_dsw22/pages/login_page.dart';
import 'package:flutter/material.dart';


class home extends StatefulWidget {
  @override
  State<home> createState() => homeState();
}

class homeState extends State<home> {
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

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text('EVALUACIÓN 2'),
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
