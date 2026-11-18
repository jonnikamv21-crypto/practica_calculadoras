
class ProductoController {
  double calcularDescuento(double precio, double porcentaje) {
    double descuento = precio * porcentaje / 100;
    return descuento;
  }

  double calcularPrecioFinal(double precio, double porcentaje) {
    double descuento = calcularDescuento(precio, porcentaje);
    return precio - descuento;
  }

  String obtenerTipoDescuento(double porcentaje) {
    if (porcentaje >= 20) {
      return 'Descuento especial';
    } else {
      return 'Descuento regular';
    }
  }
}
