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
          Text(
            habitacion.numero_habitacion,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            habitacion.id_administrador,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            habitacion.precio,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
