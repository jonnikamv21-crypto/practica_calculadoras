
class TrabajadorController {
  double calcularPago(double horas, double pagoHora) {
    double pagoTotal;

    if (horas <= 48) {
      pagoTotal = horas * pagoHora;
    } else {
      double horasNormales = 48;
      double horasExtras = horas - 48;

      double pagoNormal = horasNormales * pagoHora;
      double pagoExtra = horasExtras * pagoHora * 1.5;

      pagoTotal = pagoNormal + pagoExtra;
    }

    return pagoTotal;
  }
}
