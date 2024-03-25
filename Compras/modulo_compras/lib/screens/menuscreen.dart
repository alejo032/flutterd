import 'package:flutter/material.dart';
import 'package:modulo_compras/screens/listarproductos.dart';
import 'package:modulo_compras/screens/listarproveedores.dart';
import 'package:modulo_compras/screens/login.dart';
import 'package:modulo_compras/screens/registrarproductos.dart';
import 'package:modulo_compras/screens/registrarproveedores.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Alejandro Builes Restrepo',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        children: [

                    const ListTile(
            title: Text('Proveedores'),
            // subtitle: Text('Crear'),
            leading: Icon(
              Icons.people,
              color: Colors.orange,
            ),
            // trailing: Icon(Icons.navigate_next),
          ),
          ListTile(
            title: const Text('Crear'),
            // subtitle: const Text('Crear'),
            leading: const Icon(
              Icons.arrow_right_outlined,
              color: Colors.orange,
            ),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              final route =
                  MaterialPageRoute(builder: (context) => const RegistrarProveedores());
              Navigator.push(context, route);
            },
          ),
          ListTile(
            title: const Text('Visualizar'),
            // subtitle: const Text('Visualizar'),
            leading: const Icon(
              Icons.arrow_right_outlined,
              color: Colors.orange,
            ),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              final route = MaterialPageRoute(
                  builder: (context) => const ListarProveedores());
              Navigator.push(context, route);
            },
          ),
                    const ListTile(
            title: Text('Productos'),
            // subtitle: Text('Crear'),
            leading: Icon(
              Icons.poll_outlined,
              color: Colors.orange,
            ),
            // trailing: Icon(Icons.navigate_next),
          ),
          ListTile(
            title: const Text('Crear'),
            // subtitle: const Text('Crear'),
            leading: const Icon(
              Icons.arrow_right_outlined,
              color: Colors.orange,
            ),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              final route =
                  MaterialPageRoute(builder: (context) => const RegistrarProducto());
              Navigator.push(context, route);
            },
          ),
          ListTile(
            title: const Text('Visualizar'),
            // subtitle: const Text('Visualizar'),
            leading: const Icon(
              Icons.arrow_right_outlined,
              color: Colors.orange,
            ),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              final route = MaterialPageRoute( 
                  builder: (context) => const ListarProductos());
              Navigator.push(context, route);
            },
          ),
            ListTile(
            title: const Text('Cerrar sesion'),
            // subtitle: const Text('Crear'),
            leading: const Icon(
              Icons.logout_sharp,
              color: Colors.orange,
            ),
            onTap: () {
              final route =
              MaterialPageRoute(builder: (context) => const LoginScreen());
              Navigator.push(context, route);
            },
          ),
        ],
      ),
    );
  }
}
