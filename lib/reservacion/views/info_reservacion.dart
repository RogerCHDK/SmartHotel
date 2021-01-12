import 'package:flutter/material.dart';
import 'package:hoteles/core/models/habitacionModel.dart';
import 'package:hoteles/core/models/reservacionModel.dart';

class InfoReservacion extends StatelessWidget {
  Habitacion habitacion;
  Reservacion reservacion;
  InfoReservacion(this.habitacion, this.reservacion);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final numero = Text(
      'Número ${habitacion.numero_habitacion}',
      style: TextStyle(
          fontFamily: 'Lato', fontSize: 18.0, fontWeight: FontWeight.bold),
    );

    final tipo = Text(
      'Tipo ${habitacion.tipo_habitacion}',
      style: TextStyle(
          fontFamily: 'Lato', fontSize: 18.0, fontWeight: FontWeight.bold),
    );

    final piso = Text(
      'Piso ${habitacion.piso}',
      style: TextStyle(
          fontFamily: 'Lato', fontSize: 18.0, fontWeight: FontWeight.bold),
    );

    final vista = Text(
      'Vista ${habitacion.vista}',
      style: TextStyle(
          fontFamily: 'Lato', fontSize: 18.0, fontWeight: FontWeight.bold),
    );

    final precio = Text(
      'Precio ${habitacion.precio}',
      style: TextStyle(
          fontFamily: 'Lato', fontSize: 18.0, fontWeight: FontWeight.bold),
    );

    final dias = Text(
      '${reservacion.dias} días',
      style: TextStyle(
          fontFamily: 'Lato', fontSize: 18.0, fontWeight: FontWeight.bold),
    );

    final horas = Text(
      '${reservacion.horas} horas',
      style: TextStyle(
          fontFamily: 'Lato', fontSize: 18.0, fontWeight: FontWeight.bold),
    );

    final card = Container(
      width: screenWidth * 0.65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black38,
                blurRadius: 10.0,
                offset: Offset(0.0, 5.0))
          ]),
      child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[tipo, dias, horas, piso, vista, precio],
          )),
    );

    return Stack(
      alignment: Alignment(0.0, 0.8),
      children: <Widget>[
        card,
      ],
    );
  }
}
