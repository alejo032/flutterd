import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:modulo_compras/screens/menuscreen.dart';

class Http {
  static String url = "https://backendexamen-f4y7.onrender.com/proveedor";
  static postUsuarios(Map usuario) async {
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

class RegistrarProveedores extends StatefulWidget {
  const RegistrarProveedores({Key? key}) : super(key: key);

  @override
  State<RegistrarProveedores> createState() => _RegistrarProveedoresState();
}

class _RegistrarProveedoresState extends State<RegistrarProveedores> {
  TextEditingController nombreProveedor = TextEditingController();
  TextEditingController nombreContactoProveedor = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController nit = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proveedor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nombreProveedor,
              decoration: const InputDecoration(hintText: 'Nombre Proveedor'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nombreContactoProveedor,
              decoration: const InputDecoration(hintText: 'Nombre Contacto Proveedor'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: telefono,
              decoration: const InputDecoration(hintText: 'Teléfono'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: direccion,
              decoration: const InputDecoration(hintText: 'Dirección'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nit,
              decoration: const InputDecoration(hintText: 'NIT'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                if (nombreProveedor.text.isEmpty ||
                    nombreContactoProveedor.text.isEmpty ||
                    telefono.text.isEmpty ||
                    direccion.text.isEmpty ||
                    nit.text.isEmpty) {
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
                    "nombreProveedor": nombreProveedor.text,
                    "NombreContactoProveedor": nombreContactoProveedor.text,
                    "Telefono": telefono.text,
                    "Direccion": direccion.text,
                    "Nit": nit.text
                  };
                  print(usuario);
                  Http.postUsuarios(usuario);

                  nombreProveedor.clear();
                  nombreContactoProveedor.clear();
                  telefono.clear();
                  direccion.clear();
                  nit.clear();

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
