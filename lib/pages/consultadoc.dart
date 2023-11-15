import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConsultaDoc extends StatefulWidget {
  @override
  State<ConsultaDoc> createState() => _ConsultaState();
}

class _ConsultaState extends State<ConsultaDoc> {
  void getDoctor() async {
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
                  final doctor = snapshot.data?[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    elevation: 4.0,
                    child: ListTile(
                      title: Text("ID: ${doctor["idDoctor"]}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //agregar campo para mostrarlo en la consulta
                          Text("Nombre: ${doctor["Nombre"]}"),
                          Text("Apellidos: ${doctor["Apellido"]}"),
                          Text("Especialidad: ${doctor["Especialidad"]}"),
                          Text("Numero: ${doctor["Correo"]}"),
                          Text("Correo: ${doctor["Numero"]}")
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your action here, for example, navigate to another screen
            //Navigator.push(
            //context,
            // MaterialPageRoute(builder: (context) => ('')),
            // );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.lightBlue,
        ));
  }

  @override
  void initState() {
    super.initState();
    getDoctor();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
