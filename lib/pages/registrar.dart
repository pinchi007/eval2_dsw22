import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Registro extends StatelessWidget {
  Future<void> agregarProducto(
    String idproducto,
    String Nombre,
    String Apellido,
    String Observacion,
    String Direccion,
  ) async {
    await FirebaseFirestore.instance.collection('tb_productos').add({
      "idproducto": idproducto,
      "nombre": Nombre,
      "Apellido": Apellido,
      "Observacion": Observacion,
      "Direccion": Direccion
    });
  }

//agregar controlador para añadir campos
  TextEditingController IdController = TextEditingController();
  TextEditingController NombreController = TextEditingController();
  TextEditingController ApellidoController = TextEditingController();
  TextEditingController ObservacionController = TextEditingController();
  TextEditingController DireccionController = TextEditingController();

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
                'Registrar Pacientes',
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
                    hintText: 'Ingrese el ID del Paciente'),
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
                        'img/persona.png',
                        width: 5,
                        height: 5,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Nombres',
                    hintText: 'Ingrese el nombre del Paciente'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: ApellidoController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.lightBlue[50],
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'img/pers.png',
                        width: 5,
                        height: 5,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Apellidos',
                    hintText: 'Ingrese el Apellidos del Paciente'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: ObservacionController,
                keyboardType: TextInputType.text,
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
                    labelText: 'Observacion',
                    hintText: 'Agregar Observaciones'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: DireccionController,
                keyboardType: TextInputType.text,
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
                    labelText: 'Direccion',
                    hintText: 'Agregar Direccion de Recidencia'),
              ),
              const SizedBox(height: 15),
              //agregar campo desde el textfield hasta el sizebox para crear el campo de controlador
              ElevatedButton(
                onPressed: () async {
                  // Verifica si alguno de los campos está vacío
                  if (IdController.text.isEmpty ||
                      NombreController.text.isEmpty ||
                      ApellidoController.text.isEmpty ||
                      ObservacionController.text.isEmpty ||
                      DireccionController.text.isEmpty) {
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
                    //agregar controlador creado
                    await agregarProducto(
                        IdController.text,
                        NombreController.text,
                        ApellidoController.text,
                        ObservacionController.text,
                        DireccionController.text);

                    // Muestra un aviso de éxito después de agregar el producto
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text('Producto agregado correctamente.'),
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
                    //agregar controlador creado
                    Registro();

                    IdController.clear();
                    NombreController.clear();
                    ApellidoController.clear();
                    ObservacionController.clear();
                    DireccionController.clear();
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
