import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistroDo extends StatelessWidget {
  Future<void> agregarDoctor(
    String idDoctor,
    String Nombre,
    String Apellido,
    String Especialidad,
    String Correo,
    String Numero,
  ) async {
    //cambiar el nombre tabla por si se copia el codigo antes para agregar campos para una nuevo agregar
    await FirebaseFirestore.instance.collection('tb_doctor').add({
      "idDoctor": idDoctor,
      "Nombre": Nombre,
      "Apellido": Apellido,
      "Especialidad": Especialidad,
      "Correo": Correo,
      "Numero": Numero,
    });
  }

//agregar controlador para añadir campos
  TextEditingController IdController = TextEditingController();
  TextEditingController NombreController = TextEditingController();
  TextEditingController ApellidoController = TextEditingController();
  TextEditingController EspecialidadController = TextEditingController();
  TextEditingController CorreoController = TextEditingController();
  TextEditingController NumeroController = TextEditingController();

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
                'Registrar Doctores',
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
                    hintText: 'Ingrese el ID del Doctor'),
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
                    hintText: 'Ingrese el nombre del Doctor'),
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
                    hintText: 'Ingrese el Apellidos del Doctor'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: CorreoController,
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
                    labelText: 'Correo',
                    hintText: 'Agregar Correo'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: EspecialidadController,
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
                    labelText: 'Especialidad',
                    hintText: 'Agregar  Especialidad'),
              ),
              const SizedBox(height: 15),

              TextField(
                controller: NumeroController,
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
                    labelText: 'Numero del Doctor',
                    hintText: 'Ingrese el Numero del Doctor'),
              ),
              const SizedBox(height: 15),

              //agregar campo desde el textfield hasta el sizebox para crear el campo de controlador
              ElevatedButton(
                onPressed: () async {
                  // Verifica si alguno de los campos está vacío
                  if (IdController.text.isEmpty ||
                      NombreController.text.isEmpty ||
                      ApellidoController.text.isEmpty ||
                      NumeroController.text.isEmpty ||
                      CorreoController.text.isEmpty ||
                      EspecialidadController.text.isEmpty) {
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
                    await agregarDoctor(
                        IdController.text,
                        NombreController.text,
                        ApellidoController.text,
                        EspecialidadController.text,
                        NumeroController.text,
                        CorreoController.text);

                    // Muestra un aviso de éxito después de agregar el producto
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text('Nuevo Doctor agregado correctamente.'),
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
                    RegistroDo();

                    IdController.clear();
                    NombreController.clear();
                    ApellidoController.clear();
                    CorreoController.clear();
                    EspecialidadController.clear();
                    NumeroController.clear();
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
