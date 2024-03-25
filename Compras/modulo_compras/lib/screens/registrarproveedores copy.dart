import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:modulo_compras/screens/menuscreen.dart';


//Incorporar Future para traer la api

class Http {
  static String url = "https://backendexamen-f4y7.onrender.com/proveedor";
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
        print('falla en la insersion');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class RegistrarProveedores extends StatefulWidget {
  const RegistrarProveedores({super.key});

  @override
  State<RegistrarProveedores> createState() => _RegistrarProveedoresState();
}

TextEditingController nombreProveedor = TextEditingController();
TextEditingController Nombrecontactoproveedor = TextEditingController();
TextEditingController Telefono = TextEditingController();
TextEditingController Direccion = TextEditingController();
TextEditingController Nit = TextEditingController();

class _RegistrarProveedoresState extends State<RegistrarProveedores> {
  @override
  void initState() {
    super.initState();
    
  }

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
              decoration: const InputDecoration(hintText: 'nombre Proveedor'),
              
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Nombrecontactoproveedor,
              decoration: const InputDecoration(hintText: 'Nombre contacto proveedor'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Telefono,
              decoration: const InputDecoration(hintText: 'Telefono'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Direccion,
              decoration: const InputDecoration(hintText: 'Direccion'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: Nit,
              decoration: const InputDecoration(hintText: 'Nit'),
            ),
            
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                
                var usuario = {
                  "nombreProveedor": nombreProveedor.text,
                  "Nombrecontactoproveedor": Nombrecontactoproveedor.text,
                  "Telefono": Telefono.text,
                  "Direccion": Direccion.text,
                  "Nit": Nit.text
                };
                print(usuario);
                Http.postUsarios(usuario);

                nombreProveedor.clear();
                Nombrecontactoproveedor.clear();
                Telefono.clear();
                Direccion.clear();
                Nit.clear();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MenuScreen()),
                      
                );
                setState(() {});
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
