import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:modulo_compras/screens/login.dart';

class Http {
  static String url = "https://backendexamen-f4y7.onrender.com/usuario";
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

class RegistrarUsuarios extends StatefulWidget {
  const RegistrarUsuarios({Key? key}) : super(key: key);

  @override
  State<RegistrarUsuarios> createState() => _RegistrarUsuariosState();
}

class _RegistrarUsuariosState extends State<RegistrarUsuarios> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController Correo = TextEditingController();
  TextEditingController nombreUsuario = TextEditingController();
  TextEditingController Contrasena = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: Correo,
                decoration: const InputDecoration(hintText: 'Correo electrónico'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su correo electrónico';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nombreUsuario,
                decoration: const InputDecoration(hintText: 'Nombre de usuario'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre de usuario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: Contrasena,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Contraseña'),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var usuario = {
                      "Correo": Correo.text,
                      "nombreUsuario": nombreUsuario.text,
                      "Contrasena": Contrasena.text
                    };
                    print(usuario);
                    Http.postUsarios(usuario);

                    Correo.clear();
                    nombreUsuario.clear();
                    Contrasena.clear();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                    setState(() {});
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
