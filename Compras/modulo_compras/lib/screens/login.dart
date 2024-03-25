import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modulo_compras/screens/menuscreen.dart';
import 'package:modulo_compras/screens/registrarusuario.dart';



TextEditingController correo = TextEditingController();
TextEditingController contrasena = TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

  Future<bool> _login(BuildContext context) async {
    // Hacer la solicitud HTTP para obtener los datos de la API
    final response = await http.get(Uri.parse('https://backendexamen-f4y7.onrender.com/usuario'));
    
    if (response.statusCode == 200) {
      // Decodificar la respuesta JSON
      final data = jsonDecode(response.body);
      
      
      // Iterar sobre los usuarios de la respuesta
      for (final usuario in data['msg']) {
        // Comparar el correo y la contraseña ingresados con los de la API
        if (usuario['Correo'] == correo.text && usuario['Contrasena'] == contrasena.text) {
          // Si las credenciales son correctas, puedes redirigir a otra vista
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MenuScreen()),

          );
        correo.clear();
        contrasena.clear();
          return true;
        }
      }
    }
    
    // Si las credenciales no son correctas o la solicitud HTTP falla, devuelve falso
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              color: Colors.orange,
              height: size.height * 0.4,
            ),
            SafeArea(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                child: const Icon(
                  Icons.person_pin,
                  color: Colors.white,
                  size: 100,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 250,),
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        Text('Login',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: 30,),
                        Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: correo,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.orange)
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orange, width: 2
                                        )
                                    ),
                                    hintText: 'alejo@gmail.com',
                                    labelText: 'Correo electrónico'
                                ),
                                validator: (value) {
                                  String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                                  RegExp regExp = new RegExp(pattern);
                                  return regExp.hasMatch(value ?? '')
                                      ? null
                                      : 'El valor ingresado no es un correo';
                                },
                              ),
                              const SizedBox(height: 20,),
                              TextFormField(
                                controller: contrasena,
                                autocorrect: false,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.orange)
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.orange, width: 2
                                        )
                                    ),
                                    hintText: '****',
                                    labelText: 'Contraseña'

                                ),
                                validator: (value) {
                                  return (value != null && value.length >= 6)
                                      ? null
                                      : 'La contraseña debe ser mayor o igual a los 6 caracteres';
                                },
                              ),
                              SizedBox(height: 20,),
                              MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                disabledColor: Colors.grey,
                                color: Colors.orange,
                                child: Text('Ingresar'),
                                onPressed: () async {
                                  // Verificar el login al presionar el botón
                                  final success = await _login(context);
                                  if (!success) {
                                    // Mostrar un diálogo si las credenciales son incorrectas
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content: Text('Credenciales incorrectas.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('OK'),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 20,),
                                MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                disabledColor: Colors.grey,
                                color: Colors.orange,
                                child: Text('registrar'),
                                onPressed: () async {
                                  final route =
                                  MaterialPageRoute(builder: (context) => const RegistrarUsuarios());
                                  Navigator.push(context, route);

                                  
                                }
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


