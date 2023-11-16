import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Consultadoc extends StatefulWidget {
  @override
  State<Consultadoc> createState() => _ConsultaState();
}

class _ConsultaState extends State<Consultadoc> {
  void getProductos() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("tb_doctor");
    QuerySnapshot mensaje = await collectionReference.get();
    if (mensaje.docs.length != 0) {
      for (var doc in mensaje.docs) {
        print(doc.data());
      }
    }
  }

  Future<List> getMensajes() async {
    List chats = [];
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("tb_doctor");
    QuerySnapshot mensaje = await collectionReference.get();
    if (mensaje.docs.length != 0) {
      for (var doc in mensaje.docs) {
        print(doc.data());
        chats.add(doc.data());
      }
    }
    return chats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[50],
        title: Center(
            child: Text(
          'Consultar Datos',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
      body: FutureBuilder(
        future: getMensajes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final producto = snapshot.data?[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 4.0,
                  child: ListTile(
                    title: Text("ID: ${producto["idpruducto"]}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //agregar campo para mostrarlo en la consulta
                        Text("Nombre: ${producto["nombre"]}"),
                        Text("Apellidos: ${producto["Apellido"]}"),
                        Text("Correo: ${producto["correo"]}"),
                        Text("Especialidad: ${producto["especialidad"]}"),
                        Text("Numero del doctor: ${producto["Numero del doctor"]}")
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getProductos();
  }

  @override
  void dispose() {
    super.dispose();
  }
}