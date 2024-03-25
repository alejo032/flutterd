import 'package:flutter/material.dart';
import 'package:hoja/screens/datospersonales.dart';
import 'package:hoja/screens/estudios.dart';
import 'package:hoja/screens/habilidades.dart';


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
          'Hoja de vida',
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Alejandro Builes Restrepo'),
            subtitle: Text('Conoceme'),
            leading: Icon(
              Icons.people,
              color: Colors.orange,
            ),
            trailing: Icon(Icons.navigate_next),
          ),
          ListTile(
            title: const Text('Estudios'),
            subtitle: const Text('Que he aprendido'),
            leading: const Icon(
              Icons.arrow_right_outlined,
              color: Colors.orange,
            ),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              final route =
                  MaterialPageRoute(builder: (context) => const estudios());
              Navigator.push(context, route);
            },
          ),
          ListTile(
            title: const Text('Habilidaes'),
            subtitle: const Text('Que puedo hacer'),
            leading: const Icon(
              Icons.arrow_right_outlined,
              color: Colors.orange,
            ),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              final route = MaterialPageRoute(
                  builder: (context) => const habilidades());
              Navigator.push(context, route);
            },
          ),
          ListTile(
            title: const Text('Datos personales'),
            subtitle: const Text('quien soy'),
            leading: const Icon(
              Icons.arrow_right_outlined,
              color: Colors.orange,
            ),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              final route = MaterialPageRoute(
                  builder: (context) => const datospersonales());
              Navigator.push(context, route);
            },
          ),
        ],
      ),
    );
  }
}
