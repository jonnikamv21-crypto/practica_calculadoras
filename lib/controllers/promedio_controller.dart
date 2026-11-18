class PromedioController {

  double calcularPromedio(double n1, double n2, double n3) {
    return (n1 + n2 + n3) / 3;
  }

  String obtenerEstado(double promedio) {
    if (promedio >= 13) {
      return 'APROBADO';
    } else {
      return 'DESAPROBADO';
    }
  }
}