import 'package:flutter/material.dart';
import 'package:hoteles/hotel/views/hotel_create.dart';
import 'package:hoteles/hotel/views/hotel_index.dart';
import 'package:hoteles/hotel/views/hotel_show.dart';

class Ruta {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HotelIndex());
      case '/agregarHotel':
        return MaterialPageRoute(builder: (_) => HotelCreate());
      /*case '/hotelShow':
        return MaterialPageRoute(builder: (_) => HotelShow());*/
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
