import 'package:flutter/cupertino.dart';

class User {
  String id;
  String nombre;
  String apellido_p;
  String apellido_m;
  String correo;
  String contrasenia;
  String tipo;

  /*Hotel(
      {@required this.id,
      @required this.nombre,
      @required this.colonia,
      @required this.calle,
      @required this.municipio,
      @required this.estado,
      @required this.id_administrador,
      @required this.num_habitaciones});*/
  User({
    this.id,
    this.nombre,
    this.apellido_p,
    this.apellido_m,
    this.contrasenia,
    this.correo,
    this.tipo,
  });

  User.fromMap(Map snapshot, String id)
      : id = id ?? '',
        nombre = snapshot['nombre'] ?? '',
        apellido_p = snapshot['apellido_p'] ?? '',
        apellido_m = snapshot['apellido_m'] ?? '',
        contrasenia = snapshot['contrasenia'] ?? '',
        correo = snapshot['correo'] ?? '',
        tipo = snapshot['tipo'] ?? '';

  toJson() {
    return {
      "nombre": nombre,
      "apellido_p": apellido_p,
      "apellido_m": apellido_m,
      "contrasenia": contrasenia,
      "correo": correo,
      "tipo": tipo,
    };
  }
}
