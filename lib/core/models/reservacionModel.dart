import 'package:flutter/cupertino.dart';

class Reservacion {
  String id;
  String id_habitacion;
  String correo;
  String horas;
  String dias;

  Reservacion(
      {this.id, this.id_habitacion, this.correo, this.dias, this.horas});

  Reservacion.fromMap(Map snapshot, String id)
      : id = id ?? '',
        id_habitacion = snapshot['id_habitacion'] ?? '',
        correo = snapshot['correo'] ?? '',
        dias = snapshot['dias'] ?? '',
        horas = snapshot['horas'] ?? '';

  toJson() {
    return {
      "id_habitacion": id_habitacion,
      "correo": correo,
      "dias": dias,
      "horas": horas,
    };
  }
}
