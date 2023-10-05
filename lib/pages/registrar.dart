import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Registro extends StatelessWidget {
  Future<void> agregarProducto(
      String idproducto, String nombre, String precio, String stock) async {
    await FirebaseFirestore.instance.collection('tb_productos').add({
      "idproducto": idproducto,
      "nombre": nombre,
      "precio": precio,
      "stock": stock
    });
  }

  TextEditingController IdController = TextEditingController();
  TextEditingController NombreController = TextEditingController();
  TextEditingController PrecioController = TextEditingController();
  TextEditingController StockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Text(
                'Registrar productos',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: IdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.lightBlue[50],
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'img/id.png',
                        width: 5,
                        height: 5,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'ID',
                    hintText: 'Ingrese el ID del producto'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: NombreController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.lightBlue[50],
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'img/nombre.png',
                        width: 5,
                        height: 5,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Nombre',
                    hintText: 'Ingrese el nombre del producto'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: PrecioController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.lightBlue[50],
                    prefixIcon: const Icon(Icons.attach_money),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Precio',
                    hintText: 'Ingrese el precio del producto'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: StockController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.lightBlue[50],
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'img/stock.png',
                        width: 5,
                        height: 5,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Stock',
                    hintText: 'Ingrese el stock del producto'),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  // Verifica si alguno de los campos está vacío
                  if (IdController.text.isEmpty ||
                      NombreController.text.isEmpty ||
                      PrecioController.text.isEmpty ||
                      StockController.text.isEmpty) {
                    // Muestra un mensaje de error si algún campo está vacío
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content:
                              Text('Por favor, complete todos los campos.'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Cierra el cuadro de diálogo
                              },
                              child: Text('Aceptar'),
                            ),
                          ],
                        );
                      },
                    );
                    return; // Sale de la función sin agregar el producto
                  }

                  try {
                    await agregarProducto(
                        IdController.text,
                        NombreController.text,
                        PrecioController.text,
                        StockController.text);

                    // Muestra un aviso de éxito después de agregar el producto
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          
                          content:
                              Text('Producto agregado correctamente.'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Cierra el cuadro de diálogo
                              },
                              child: Text('Aceptar'),
                            ),
                          ],
                        );
                      },
                    );

                    // Realiza el registro y luego limpia los campos
                    Registro();

                    IdController.clear();
                    NombreController.clear();
                    PrecioController.clear();
                    StockController.clear();
                  } catch (e) {
                    // Maneja cualquier excepción que pueda ocurrir al agregar el producto.
                    print("Error al agregar el producto: $e");
                    // Puedes mostrar un mensaje de error o tomar otras acciones según tus necesidades.
                  }
                },
                child: const Text(
                  'Agregar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black, // Color del texto
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue[200], // Color de fondo del botón
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Bordes redondeados
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 12, horizontal: 24), // Espaciado interno
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
