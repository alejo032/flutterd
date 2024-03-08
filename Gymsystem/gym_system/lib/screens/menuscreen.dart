import 'package:flutter/material.dart';
import 'package:gym_system/screens/categoria.dart';



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
          'Modulo compras',
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
        backgroundColor: const Color.fromARGB(255, 28, 85, 131),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Categoria Productos'),
            subtitle: Text('Crear'),
            leading: Icon(
              Icons.people,
              color: Color.fromARGB(255, 28, 85, 131),
            ),
            trailing: Icon(Icons.navigate_next),
          ),
          ListTile(
            title: const Text('Categoria Productos'),
            subtitle: const Text('Crear'),
            leading: const Icon(
              Icons.arrow_right_outlined,
              color: Color.fromARGB(255, 28, 85, 131),
            ),
            trailing: const Icon(Icons.navigate_next),
            onTap: () {
              final route =
                  MaterialPageRoute(builder: (context) => const categoriaScreen());
              Navigator.push(context, route);
            },
          ),
          // ListTile(
          //   title: const Text('infracciones'),
          //   subtitle: const Text('Que puedo hacer'),
          //   leading: const Icon(
          //     Icons.arrow_right_outlined,
          //     color: Colors.orange,
          //   ),
          //   trailing: const Icon(Icons.navigate_next),
          //   onTap: () {
          //     final route = MaterialPageRoute(
          //         builder: (context) => const InfraccionesScreeen());
          //     Navigator.push(context, route);
          //   },
          // ),
        ],
      ),
    );
  }
}