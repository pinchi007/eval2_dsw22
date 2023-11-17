import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConsultaDoc extends StatefulWidget {
  @override
  State<ConsultaDoc> createState() => _ConsultaState();
}

class _ConsultaState extends State<ConsultaDoc> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  void getdoctor() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("tb_doctor");
    QuerySnapshot mensaje = await collectionReference.get();
    if (mensaje.docs.length != 0) {
      for (var doc in mensaje.docs) {
        print(doc.data());
      }
    }
  }

//funcion Eliminar
  Future<void> deleteDoctor(String uid) async {
    try {
      await db.collection("tb_doctor").doc(uid).delete();
      print('Doctor eliminado correctamente.');
    } catch (error) {
      print('Error al eliminar el doctor: $error');
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
        backgroundColor: Colors.green[100],
        title: Center(
          child: Text(
            'Consultar Datos',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder(
        future: getMensajes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar datos'),
            );
          } else if (!snapshot.hasData || snapshot.data?.isEmpty == true) {
            return Center(
              child: Text('No hay datos disponibles'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final doctor = snapshot.data?[index];
                return Dismissible(
                  key: Key(doctor?["idDoctor"] ?? ''),
                  onDismissed: (direction) async {
                    deleteDoctor(snapshot.data?[index]['uid']);
                  },
                  confirmDismiss: (direction) async {
                    bool result = await showDialog(
                      context: context,
                      builder: (context) {
                        //Alerta de dialogo para eliminar y cancelar

                        return AlertDialog(
                          title: Text(
                            "¿Está seguro de querer eliminar a ${doctor?["Nombre"]}?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text(
                                "Cancelar",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              child: const Text("Sí, estoy seguro"),
                            ),
                          ],
                        );
                      },
                    );
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: Card(
                    margin: EdgeInsets.all(8.0),
                    elevation: 4.0,
                    child: ListTile(
                      //Consulta de datos

                      title: Text("ID: ${doctor?["idDoctor"]}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nombre: ${doctor?["Nombre"]}"),
                          Text("Apellidos: ${doctor?["Apellido"]}"),
                          Text("Correo: ${doctor?["Numero"]}"),
                          Text("Especialidad: ${doctor?["Especialidad"]}"),
                          Text("Numero del doctor: ${doctor?["Correo"]}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getdoctor();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
