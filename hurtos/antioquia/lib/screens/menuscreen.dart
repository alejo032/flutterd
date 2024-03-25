import 'package:antioquia/screens/listar_departamentos.dart';
import 'package:antioquia/screens/registar.dart';
import 'package:flutter/material.dart';



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
          'Exportaciones Gymsystem',
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Exportaciones'),
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
                  MaterialPageRoute(builder: (context) => const Registrar());
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
                  builder: (context) => const ListarExportaciones());
              Navigator.push(context, route);
            },
          ),
        ],
      ),
    );
  }
}