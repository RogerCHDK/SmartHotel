import 'package:flutter/material.dart';
import 'package:hoteles/core/models/hotelModel.dart';
import 'package:hoteles/user/widgets/user_info.dart';
import 'package:hoteles/widgets/button_bar.dart';

class ProfileHeader extends StatelessWidget {
  String usuario_id;
  Hotel hotel;
  ProfileHeader(this.usuario_id, this.hotel);
  @override
  Widget build(BuildContext context) {
    if (hotel == null) {
      final title = Text(
        'Hotel',
        style: TextStyle(
            fontFamily: 'Lato',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0),
      );
      //aqui entra si el usuario no tiene hoteles
      return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[title],
            ),
            UserInfo(
                usuario_id), //le pasamos el objeto que contiene ya los datos del usuario
            ButtonsBar(false, null)
          ],
        ),
      );
    } else {
      final title = Text(
        'Hotel ${hotel.nombre}',
        style: TextStyle(
            fontFamily: 'Lato',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0),
      );
      //aqui entra en caso de que se cuente con un hotel
      return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[title],
            ),
            UserInfo(
                usuario_id), //le pasamos el objeto que contiene ya los datos del usuario
            ButtonsBar(true, hotel)
          ],
        ),
      );
    }
  }
}
