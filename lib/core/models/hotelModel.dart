import 'package:flutter/cupertino.dart';

class Hotel {
  String id;
  String nombre;
  String colonia;
  String calle;
  String municipio;
  String estado;
  String id_administrador;
  String num_habitaciones;

  /*Hotel(
      {@required this.id,
      @required this.nombre,
      @required this.colonia,
      @required this.calle,
      @required this.municipio,
      @required this.estado,
      @required this.id_administrador,
      @required this.num_habitaciones});*/
  Hotel(
      {this.id,
      this.nombre,
      this.colonia,
      this.calle,
      this.municipio,
      this.estado,
      this.id_administrador,
      this.num_habitaciones});

  Hotel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        nombre = snapshot['nombre'] ?? '',
        colonia = snapshot['colonia'] ?? '',
        calle = snapshot['calle'] ?? '',
        municipio = snapshot['municipio'] ?? '',
        estado = snapshot['estado'] ?? '',
        id_administrador = snapshot['id_administrador'] ?? '',
        num_habitaciones = snapshot['num_habitaciones'] ?? '';

  toJson() {
    return {
      "nombre": nombre,
      "colonia": colonia,
      "calle": calle,
      "municipio": municipio,
      "estado": estado,
      "id_administrador": id_administrador,
      "num_habitaciones": num_habitaciones,
    };
  }
}
