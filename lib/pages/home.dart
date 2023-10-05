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
    }
  }

  void _onSelectItemDrawer(int pos) {
    Navigator.pop(context);
    setState(() {
      ItemDrawer = pos;
    });
  }
  }
  