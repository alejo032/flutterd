import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  TextEditingController nombreProyecto = TextEditingController();
  TextEditingController puntajeProyecto = TextEditingController();
  Uint8List? fotoBytes;
  final _formKey = GlobalKey<FormState>();
  Position? currentPosition;
  GoogleMapController? mapController;

  Future<void> _tomarFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      try {
        final bytes = await pickedFile.readAsBytes();
        final image = img.decodeImage(bytes);
        if (image == null) {
          throw Exception('Error al decodificar la imagen');
        }
        final resizedImage = img.copyResize(image, width: 300);
        final compressedBytes = img.encodeJpg(resizedImage, quality: 85);

        setState(() {
          fotoBytes = Uint8List.fromList(compressedBytes);
        });
      } catch (e) {
        print('Error al procesar la imagen: $e');
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentPosition = position;
      });
    } catch (e) {
      print('Error al obtener la ubicación: $e');
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
          child: ListView(
            children: [
              TextFormField(
                controller: nombreProyecto,
                decoration:
                    const InputDecoration(labelText: 'Nombre del Proyecto'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: puntajeProyecto,
                decoration:
                    const InputDecoration(labelText: 'Puntaje del Proyecto'),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _tomarFoto,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Tomar Foto'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
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
                      "Foto": base64Encode(fotoBytes!),
                    };
                    print(proyecto);

                    nombreProyecto.clear();
                    puntajeProyecto.clear();
                    setState(() {
                      fotoBytes = null;
                    });
                  }
                },
                icon: const Icon(Icons.maps_ugc_sharp),
                label: const Text('Registrar'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text('Obtener Ubicación'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              if (currentPosition != null)
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Latitud: ${currentPosition!.latitude}',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Longitud: ${currentPosition!.longitude}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
