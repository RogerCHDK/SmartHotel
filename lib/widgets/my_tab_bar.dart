import 'package:flutter/material.dart';
import 'package:hoteles/habitacion/views/habitacion_index.dart';
import 'package:hoteles/hotel/views/hotel_index.dart';
import 'package:hoteles/hotel/views/hotel_show_admon.dart';
import 'package:hoteles/reservacion/views/reservacion_create.dart';
import 'package:hoteles/user/views/profile.dart';

class MyTabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //throw UnimplementedError();
    return _MyTabBar();
  }
}

class _MyTabBar extends State<MyTabBar> {
  int indexTap = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetsChildren = [
      Profile(),
      HabitacionIndex(),
      ReservacionCreate(),
    ];
    return Scaffold(
      body: widgetsChildren[indexTap],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black, //es el color de la barra
          primaryColor: Colors.white, //es el color de los iconos
        ), //la personalizacion
        child: BottomNavigationBar(
            onTap: onTapTapped, //le pasa automaticamente el indice
            currentIndex:
                indexTap, //le decimos que indice tiene, para que sepa que mostrar
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text("Hotel")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), title: Text("Habitaciones")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.warning), title: Text("Reservaciones")),
            ]),
      ),
    );
  }

  void onTapTapped(int index) {
    //este metodo sirve para identificar que icono se selecciono
    setState(() {
      indexTap = index;
    });
  }
}
