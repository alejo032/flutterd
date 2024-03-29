import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:proyectos/screens/MenuScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class Http {
  static String url = "https://apiproyects.onrender.com/proyecto";
  static postProyectos(Map proyecto) async {
    try {
      final res = await http.post(
        Uri.parse(url),
        headers: {'content-Type': 'application/json'},
        body: json.encode(proyecto),
      );
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print('Error en la inserción: ${res.reasonPhrase}');
      }
    } catch (e) {
      print('Error de conexión: $e');
    }
  }
}

class RegistrarProyecto extends StatefulWidget {
  const RegistrarProyecto({Key? key}) : super(key: key);

  @override
  State<RegistrarProyecto> createState() => _RegistrarProyectoState();
}

class _RegistrarProyectoState extends State<RegistrarProyecto> {
  TextEditingController nombreProyecto = TextEditingController();
  TextEditingController puntajeProyecto = TextEditingController();
  Uint8List? fotoBytes; // Variable para almacenar la foto seleccionada
  final _formKey = GlobalKey<FormState>();

  // Método para abrir la cámara y tomar una foto
  Future<void> _tomarFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      try {
        final bytes = await pickedFile.readAsBytes();

        // Redimensionar la imagen antes de almacenarla
        final image = img.decodeImage(bytes);
        if (image == null) {
          throw Exception('Error al decodificar la imagen');
        }

        // Redimensionar la imagen a una resolución más baja
        final resizedImage = img.copyResize(image, width: 300);

        // Comprimir la imagen ajustando la calidad de compresión
        final compressedBytes = img.encodeJpg(resizedImage, quality: 85);

        setState(() {
          fotoBytes = Uint8List.fromList(compressedBytes);
        });
      } catch (e) {
        print('Error al procesar la imagen: $e');
        // Manejar el error aquí
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyecto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nombreProyecto,
                decoration: const InputDecoration(labelText: 'Nombre del Proyecto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre del proyecto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: puntajeProyecto,
                decoration: const InputDecoration(labelText: 'Puntaje del Proyecto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el puntaje del proyecto';
                  }
                  final puntaje = int.tryParse(value);
                  if (puntaje == null || puntaje < 1 || puntaje > 5) {
                    return 'El puntaje debe ser un número entre 1 y 5';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _tomarFoto,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Tomar Foto'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              // Visualización de la foto seleccionada
              if (fotoBytes != null)
                Image.memory(
                  fotoBytes!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate() && fotoBytes != null) {
                    var proyecto = {
                      "nombreProyecto": nombreProyecto.text,
                      "puntajeProyecto": puntajeProyecto.text,
                      // Convertir la foto a base64
                      "Foto": base64Encode(fotoBytes!),
                    };
                    print(proyecto);
                    Http.postProyectos(proyecto);

                    nombreProyecto.clear();
                    puntajeProyecto.clear();
                    setState(() {
                      fotoBytes = null;
                    });

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MenuScreen()),
                    );
                  }
                },
                icon: const Icon(Icons.maps_ugc_sharp),
                label: const Text('Registrar'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
