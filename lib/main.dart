import 'package:flutter/material.dart';
import 'screen/screen_promedio.dart';
import 'screen/screen_trabajador.dart';
import 'screen/screen_producto.dart';
import 'screen/screen_combustible.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenTrabajador(),
      );
     
  }
}

