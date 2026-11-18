
import 'package:flutter/material.dart';
import 'package:practica_calculadoras/controllers/trabajador_controller.dart';

class ScreenTrabajador extends StatefulWidget {
  const ScreenTrabajador({super.key});

  @override
  State<ScreenTrabajador> createState() => _ScreenTrabajadorState();
}

class _ScreenTrabajadorState extends State<ScreenTrabajador> {
  final nombre = TextEditingController();
  final horas = TextEditingController();
  final pagoHora = TextEditingController();

  final objetoTrabajador = TrabajadorController();

  double respuesta = 0;
  String mensaje = '';

  void calcular() {
    if (nombre.text.trim().isEmpty ||
        horas.text.trim().isEmpty ||
        pagoHora.text.trim().isEmpty) {
      setState(() {
        mensaje = 'Complete todos los campos';
        respuesta = 0;
      });
      return;
    }

    double? h = double.tryParse(horas.text);
    double? p = double.tryParse(pagoHora.text);

    if (h == null || p == null) {
      setState(() {
        mensaje = 'Ingrese valores numéricos válidos';
        respuesta = 0;
      });
      return;
    }

    if (h < 0 || p < 0) {
      setState(() {
        mensaje = 'No se permiten valores negativos';
        respuesta = 0;
      });
      return;
    }

    setState(() {
      respuesta = objetoTrabajador.calcularPago(h, p);
      mensaje = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pago semanal'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'CALCULADORA DE PAGO SEMANAL',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: nombre,
              decoration: const InputDecoration(
                labelText: 'Nombre del trabajador',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: horas,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Horas trabajadas',
                prefixIcon: Icon(Icons.access_time),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: pagoHora,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Pago por hora (S/)',
                prefixIcon: Icon(Icons.payments),
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
              child: const Text('Calcular pago'),
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

            if (mensaje.isEmpty && respuesta > 0)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      'Trabajador: ${nombre.text}',
                      style: const TextStyle(fontSize: 18),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      'Pago total: S/ ${respuesta.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
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
    nombre.dispose();
    horas.dispose();
    pagoHora.dispose();
    super.dispose();
  }
}
