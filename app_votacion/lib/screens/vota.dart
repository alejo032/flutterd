import 'package:flutter/material.dart';

class votacion extends StatefulWidget {
  const votacion({super.key});

  @override
  State<votacion> createState() => _votacionState();
}




int contadorClickTriangulo = 0;
int contadorClickRombo = 0;
int contadorClickCuadrado = 0;
int suma = contadorClickCuadrado+contadorClickRombo+contadorClickTriangulo;
double porcentajetr = contadorClickTriangulo/suma*100;
double porcentajero = contadorClickRombo/suma*100;
double porcentajecu = contadorClickTriangulo/suma*100;

class _votacionState extends State<votacion> {
  @override
  Widget build(BuildContext context) {
    int suma = contadorClickCuadrado + contadorClickRombo + contadorClickTriangulo;
    double porcentajetr = suma != 0 ? (contadorClickTriangulo / suma) * 100 : 0;
    double porcentajero = suma != 0 ? (contadorClickRombo / suma) * 100 : 0;
    double porcentajecu = suma != 0 ? (contadorClickCuadrado / suma) * 100 : 0;

    String lider = '';

    if (contadorClickTriangulo >= contadorClickRombo && contadorClickTriangulo >= contadorClickCuadrado) {
      lider = 'Triángulo';
    } else if (contadorClickRombo >= contadorClickTriangulo && contadorClickRombo >= contadorClickCuadrado) {
      lider = 'Rombo';
    } else {
      lider = 'Cuadrado';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("App Votacion"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  CustomPaint(
                    size: const Size(100, 100),
                    painter: TrianglePainter(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        contadorClickTriangulo++;
                      });
                    },
                    child: const Text('Votar'),
                  ),
                  Text('Votos Triángulo: $contadorClickTriangulo'),
                  Text('Porcentaje: $porcentajetr'),
                ],
              ),
              Column(
                children: [
                  CustomPaint(
                    size: const Size(100, 100),
                    painter: RhombusPainter(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        contadorClickRombo++;
                      });
                    },
                    child: const Text('Votar'),
                  ),
                  Text('Votos Rombo: $contadorClickRombo'),
                  Text('Porcentaje: $porcentajero'),
                ],
              ),
              Column(
                children: [
                  CustomPaint(
                    size: const Size(100, 100),
                    painter: SquarePainter(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        contadorClickCuadrado++;
                      });
                    },
                    child: const Text('Votar'),
                  ),
                  Text('Votos Cuadrado: $contadorClickCuadrado'),
                  Text('Porcentaje: $porcentajecu'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Total de votos: $suma',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Líder actual: $lider',
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}





class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class RhombusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height / 2);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class SquarePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
