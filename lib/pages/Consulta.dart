import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Consulta extends StatefulWidget {
  @override
  State<Consulta> createState() => _ConsultaState();
}

class _ConsultaState extends State<Consulta> {
  void getProductos() async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("tb_productos");
    QuerySnapshot mensaje = await collectionReference.get();
    if (mensaje.docs.length != 0){
      for (var doc in mensaje.docs){
        print(doc.data());
      }
    }
  }

  Future<List> getMensajes() async {
    List chats = [];
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("tb_productos");
    QuerySnapshot mensaje = await collectionReference.get();
    if (mensaje.docs.length != 0){
      for (var doc in mensaje.docs){
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
        title: Center(child: Text('Consultar Datos', style: TextStyle(fontWeight: FontWeight.bold),)),
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
                    title: Text("ID: ${producto["idproducto"]}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Nombre: ${producto["nombre"]}"),
                        Text("Precio: ${producto["precio"]}"),
                        Text("Stock: ${producto["stock"]}"),
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
        onPressed: getProductos,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
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
