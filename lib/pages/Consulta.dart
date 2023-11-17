import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConsultaPa extends StatefulWidget {
  @override
  State<ConsultaPa> createState() => _ConsultaState();
}

class _ConsultaState extends State<ConsultaPa> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  void getproductos() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("tb_productos");
    QuerySnapshot mensaje = await collectionReference.get();
    if (mensaje.docs.length != 0) {
      for (var doc in mensaje.docs) {
        print(doc.data());
      }
    }
  }

//funcion Eliminar
  Future<void> deleteproductos(String idProducto) async {
    try {
      await db.collection("tb_productos").doc(idProducto).delete();
      print('Producto eliminado correctamente.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Producto eliminado correctamente'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      print('Error al eliminar el producto: $error');
    }
  }

  Future<List> getMensajes() async {
    List chats = [];
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("tb_productos");
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
            'Datos Personales Y Historial',
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
                final productos = snapshot.data?[index];
                return Dismissible(
                  key: Key(productos?["idproducto"] ?? ''),
                  onDismissed: (direction) async {
                    await deleteproductos(snapshot.data?[index]['idproducto']);
                  },
                  confirmDismiss: (direction) async {
                    bool result = await showDialog(
                      context: context,
                      builder: (context) {
                        //Alerta de dialogo para eliminar y cancelar con ventana
                        return AlertDialog(
                          title: Text(
                            "¿Está seguro de querer eliminar a ${productos?["nombre"]}?",
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
                      title: Text("ID: ${productos?["idproducto"]}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nombre: ${productos?["nombre"]}"),
                          Text("Apellidos: ${productos?["Apellido"]}"),
                          Text("Direccion: ${productos?["Direccion"]}"),
                          Text("Observacion: ${productos?["Observacion"]}"),
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
    getproductos();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
