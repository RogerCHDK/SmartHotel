import 'package:flutter/material.dart';
import 'package:hoteles/hotel/views/hotel_create.dart';
import 'package:hoteles/hotel/views/hotel_index.dart';
import 'package:hoteles/hotel/views/hotel_show.dart';
import 'package:hoteles/user/login_page.dart';
import 'package:hoteles/widgets/my_tab_bar.dart';

class Ruta {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/principal':
        return MaterialPageRoute(builder: (_) => MyTabBar());
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
