
import 'package:flutter/material.dart';
import 'package:practica_calculadoras/controllers/producto_controller.dart';

class ScreenProducto extends StatefulWidget {
  const ScreenProducto({super.key});

  @override
  State<ScreenProducto> createState() => _ScreenProductoState();
}

class _ScreenProductoState extends State<ScreenProducto> {
  final nombre = TextEditingController();
  final precio = TextEditingController();
  final porcentaje = TextEditingController();

  final objetoProducto = ProductoController();

  double descuento = 0;
  double precioFinal = 0;
  String tipoDescuento = '';
  String mensaje = '';

  void calcular() {
    if (nombre.text.trim().isEmpty ||
        precio.text.trim().isEmpty ||
        porcentaje.text.trim().isEmpty) {
      setState(() {
        mensaje = 'Complete todos los campos';
        tipoDescuento = '';
        descuento = 0;
        precioFinal = 0;
      });
      return;
    }

    double? p = double.tryParse(precio.text);
    double? d = double.tryParse(porcentaje.text);

    if (p == null || d == null) {
      setState(() {
        mensaje = 'Ingrese valores numéricos válidos';
        tipoDescuento = '';
        descuento = 0;
        precioFinal = 0;
      });
      return;
    }

    if (p <= 0) {
      setState(() {
        mensaje = 'El precio debe ser mayor que cero';
        tipoDescuento = '';
        descuento = 0;
        precioFinal = 0;
      });
      return;
    }

    if (d < 0 || d > 100) {
      setState(() {
        mensaje = 'El descuento debe estar entre 0 y 100%';
        tipoDescuento = '';
        descuento = 0;
        precioFinal = 0;
      });
      return;
    }

    setState(() {
      descuento = objetoProducto.calcularDescuento(p, d);
      precioFinal = objetoProducto.calcularPrecioFinal(p, d);
      tipoDescuento = objetoProducto.obtenerTipoDescuento(d);
      mensaje = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Descuento de productos'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'CALCULADORA DE DESCUENTOS',
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
                labelText: 'Nombre del producto',
                prefixIcon: Icon(Icons.shopping_bag),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: precio,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Precio del producto (S/)',
                prefixIcon: Icon(Icons.payments),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: porcentaje,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Porcentaje de descuento (%)',
                prefixIcon: Icon(Icons.percent),
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
              child: const Text('Calcular descuento'),
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

            if (mensaje.isEmpty && tipoDescuento.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      'Producto: ${nombre.text}',
                      style: const TextStyle(fontSize: 18),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      'Tipo: $tipoDescuento',
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Descuento: S/ ${descuento.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Precio final: S/ ${precioFinal.toStringAsFixed(2)}',
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
    precio.dispose();
    porcentaje.dispose();
    super.dispose();
  }
}
