import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:modulo_compras/screens/menuscreen.dart';

class Http {
  static String url = "https://backendexamen-f4y7.onrender.com/producto";
  static postUsarios(Map usuario) async {
    try {
      final res = await http.post(
        Uri.parse(url),
        headers: {'content-Type': 'application/json'},
        body: json.encode(usuario),
      );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print('falla en la inserción');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class RegistrarProducto extends StatefulWidget {
  const RegistrarProducto({super.key});

  @override
  State<RegistrarProducto> createState() => _RegistrarProductoState();
}

class _RegistrarProductoState extends State<RegistrarProducto> {
  TextEditingController nombreProducto = TextEditingController();
  TextEditingController precioProducto = TextEditingController();
  TextEditingController ivaProducto = TextEditingController();
  TextEditingController Existencias = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nombreProducto,
              decoration: const InputDecoration(hintText: 'nombreProducto'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: precioProducto,
              decoration: const InputDecoration(hintText: 'precioProducto'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: ivaProducto,
              decoration: const InputDecoration(hintText: 'ivaProducto'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Existencias,
              decoration: const InputDecoration(hintText: 'Existencias'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                if (nombreProducto.text.isEmpty ||
                    precioProducto.text.isEmpty ||
                    ivaProducto.text.isEmpty ||
                    Existencias.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Por favor, completa todos los campos.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  var usuario = {
                    "nombreProducto": nombreProducto.text,
                    "precioProducto": precioProducto.text,
                    "ivaProducto": ivaProducto.text,
                    "Existencias": Existencias.text
                  };
                  print(usuario);
                  Http.postUsarios(usuario);

                  nombreProducto.clear();
                  precioProducto.clear();
                  ivaProducto.clear();
                  Existencias.clear();

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
    );
  }
}
