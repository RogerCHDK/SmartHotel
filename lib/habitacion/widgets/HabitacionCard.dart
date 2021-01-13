import 'package:flutter/material.dart';
import 'package:hoteles/core/models/habitacionModel.dart';
import 'package:hoteles/habitacion/views/habitacion_show.dart';

class HabitacionCard extends StatelessWidget {
  final Habitacion habitacionDetails;
  HabitacionCard({@required this.habitacionDetails});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => HabitacionShow(habitacion: habitacionDetails)));
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          elevation: 5,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: <Widget>[
                Hero(
                  tag: habitacionDetails.id,
                  child: Image.asset(
                    'assets/img/habitacion${habitacionDetails.numero_habitacion}.jpg',
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Habitación Num. ${habitacionDetails.numero_habitacion}',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
