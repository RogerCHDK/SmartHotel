import 'package:flutter/cupertino.dart';

class Habitacion {
  String id;
  String tipo_habitacion;
  String numero_habitacion;
  String piso;
  String vista;
  String precio;
  String id_administrador;
  String status;

  Habitacion(
      {this.id,
      this.tipo_habitacion,
      this.numero_habitacion,
      this.piso,
      this.vista,
      this.precio,
      this.id_administrador,
      this.status});

  Habitacion.fromMap(Map snapshot, String id)
      : id = id ?? '',
        tipo_habitacion = snapshot['tipo_habitacion'] ?? '',
        numero_habitacion = snapshot['numero_habitacion'] ?? '',
        piso = snapshot['piso'] ?? '',
        vista = snapshot['vista'] ?? '',
        precio = snapshot['precio'] ?? '',
        id_administrador = snapshot['id_administrador'] ?? '',
        status = snapshot['status'] ?? '';

  toJson() {
    return {
      "tipo_habitacion": tipo_habitacion,
      "numero_habitacion": numero_habitacion,
      "piso": piso,
      "vista": vista,
      "precio": precio,
      "id_administrador": id_administrador,
      "status": status,
    };
  }
}
