import 'package:flutter/material.dart';
import 'package:practica_calculadoras/controllers/promedio_controller.dart';

class ScreenPromedio extends StatefulWidget {
  const ScreenPromedio({super.key});

  @override
  State<ScreenPromedio> createState() => _ScreenPromedioState();
}

class _ScreenPromedioState extends State<ScreenPromedio> {
  final nombre = TextEditingController();
  final nota1 = TextEditingController();
  final nota2 = TextEditingController();
  final nota3 = TextEditingController();

  final objetopromedio = PromedioController();

  double respuesta = 0;
  String estado = '';
  String mensaje = '';

  void calcular() {
    if (nombre.text.trim().isEmpty ||
        nota1.text.isEmpty ||
        nota2.text.isEmpty ||
        nota3.text.isEmpty) {
      setState(() {
        mensaje = 'Complete todos los campos';
        estado = '';
        respuesta = 0;
      });
      return;
    }

    double? n1 = double.tryParse(nota1.text);
    double? n2 = double.tryParse(nota2.text);
    double? n3 = double.tryParse(nota3.text);

    if (n1 == null || n2 == null || n3 == null) {
      setState(() {
        mensaje = 'Ingrese valores numéricos válidos';
        estado = '';
        respuesta = 0;
      });
      return;
    }

    if (n1 < 0 || n1 > 20 ||
        n2 < 0 || n2 > 20 ||
        n3 < 0 || n3 > 20) {
      setState(() {
        mensaje = 'Las notas deben estar entre 0 y 20';
        estado = '';
        respuesta = 0;
      });
      return;
    }

    setState(() {
      respuesta = objetopromedio.calcularPromedio(n1, n2, n3);
      estado = objetopromedio.obtenerEstado(respuesta);
      mensaje = '';
    });
  }

  Widget campoNota(String etiqueta, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: etiqueta,
          prefixIcon: const Icon(Icons.school),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promedio académico'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'CALCULADORA DE PROMEDIO',
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
                labelText: 'Nombre del estudiante',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            campoNota('Nota 1', nota1),
            campoNota('Nota 2', nota2),
            campoNota('Nota 3', nota3),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () => calcular(),
              child: const Text('Calcular promedio'),
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

            if (estado.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      'Estudiante: ${nombre.text}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Promedio: ${respuesta.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      estado,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: estado == 'APROBADO'
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
    nombre.dispose();
    nota1.dispose();
    nota2.dispose();
    nota3.dispose();
    super.dispose();
  }
}
