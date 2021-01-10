import 'package:flutter/material.dart';
import 'package:hoteles/habitacion/views/habitacion_show_user.dart';
import 'package:hoteles/hotel/views/hotel_index_user.dart';
import 'package:hoteles/user/views/control.dart';

class TabBarUser extends StatefulWidget {
  @override
  _TabBarUserState createState() => _TabBarUserState();
}

class _TabBarUserState extends State<TabBarUser> {
  int indexTap = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetsChildren = [
      HabitacionShowUser(),
      Control(),
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
                  icon: Icon(Icons.home), title: Text("Habitacion")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), title: Text("Control")),
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
