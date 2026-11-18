
import 'package:flutter/material.dart';
import 'package:practica_calculadoras/controllers/combustible_controller.dart';

class ScreenCombustible extends StatefulWidget {
  const ScreenCombustible({super.key});

  @override
  State<ScreenCombustible> createState() => _ScreenCombustibleState();
}

class _ScreenCombustibleState extends State<ScreenCombustible> {
  final marca = TextEditingController();
  final distancia = TextEditingController();
  final litros = TextEditingController();

  final objetoCombustible = CombustibleController();

  double rendimiento = 0;
  String estado = '';
  String mensaje = '';

  void calcular() {
    if (marca.text.trim().isEmpty ||
        distancia.text.trim().isEmpty ||
        litros.text.trim().isEmpty) {
      setState(() {
        mensaje = 'Complete todos los campos';
        estado = '';
        rendimiento = 0;
      });
      return;
    }

    double? d = double.tryParse(distancia.text);
    double? l = double.tryParse(litros.text);

    if (d == null || l == null) {
      setState(() {
        mensaje = 'Ingrese valores numéricos válidos';
        estado = '';
        rendimiento = 0;
      });
      return;
    }

    if (d <= 0 || l <= 0) {
      setState(() {
        mensaje = 'La distancia y los litros deben ser mayores que cero';
        estado = '';
        rendimiento = 0;
      });
      return;
    }

    setState(() {
      rendimiento = objetoCombustible.calcularRendimiento(d, l);
      estado = objetoCombustible.obtenerEstado(rendimiento);
      mensaje = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo de combustible'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'CALCULADORA DE COMBUSTIBLE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: marca,
              decoration: const InputDecoration(
                labelText: 'Marca del vehículo',
                prefixIcon: Icon(Icons.directions_car),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: distancia,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Distancia recorrida (km)',
                prefixIcon: Icon(Icons.route),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: litros,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Litros consumidos',
                prefixIcon: Icon(Icons.local_gas_station),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: calcular,
              child: const Text('Calcular rendimiento'),
            ),

            const SizedBox(height: 25),

            if (mensaje.isNotEmpty)
              Text(
                mensaje,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

            if (mensaje.isEmpty && estado.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      'Vehículo: ${marca.text}',
                      style: const TextStyle(fontSize: 18),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      'Rendimiento: ${rendimiento.toStringAsFixed(2)} km/L',
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      estado,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: rendimiento >= 15
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    marca.dispose();
    distancia.dispose();
    litros.dispose();
    super.dispose();
  }
}
