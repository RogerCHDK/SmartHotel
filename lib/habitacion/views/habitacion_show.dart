import 'package:flutter/material.dart';
import 'package:hoteles/core/models/habitacionModel.dart';
import 'package:hoteles/core/viewmodels/CRUDHabitacion.dart';
import 'package:hoteles/habitacion/views/habitacion_modify.dart';
import 'package:provider/provider.dart';

class HabitacionShow extends StatelessWidget {
  final Habitacion habitacion;
  HabitacionShow({@required this.habitacion});
  @override
  Widget build(BuildContext context) {
    final habitacionProvider = Provider.of<CRUDHabitacion>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles Habitacion'),
        actions: <Widget>[
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.delete_forever),
            onPressed: () async {
              await habitacionProvider.removeHabitacion(habitacion.id);
              Navigator.pop(context);
            },
          ),
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => HabitacionModify(
                            habitacion: habitacion,
                          )));
            },
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: "he",
            child: Image.asset(
              'assets/img/habitacion${habitacion.numero_habitacion}.jpg',
              height: MediaQuery.of(context).size.height * 0.35,
            ),
          ),
          Text(
            'Número de habitación: ${habitacion.numero_habitacion}',
            style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Tipo de habitación: ${habitacion.tipo_habitacion}',
            style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Piso de la habitación: ${habitacion.piso}',
            style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Vista de la habitación: ${habitacion.vista}',
            style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Precio de la habitación: ${habitacion.precio}',
            style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
