import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/hotelModel.dart';
import 'package:hoteles/core/viewmodels/CRUDHotel.dart';
import 'package:hoteles/hotel/views/hotel_create.dart';
import 'package:hoteles/hotel/views/hotel_modify.dart';
import 'package:hoteles/widgets/circle_button.dart';
import 'package:hoteles/widgets/my_tab_bar.dart';
import 'package:provider/provider.dart';

class ButtonsBar extends StatelessWidget {
  bool auxiliar;
  Hotel hotel;
  ButtonsBar(this.auxiliar, this.hotel);
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<CRUDHotel>(context);
    if (auxiliar) {
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              CircleButton(true, Icons.delete_forever, 20.0,
                  Color.fromRGBO(255, 255, 255, 0.6), () async {
                await hotelProvider.removeHotel(hotel.id);
                Navigator.push(
                    context, new MaterialPageRoute(builder: (_) => MyTabBar()));
              }),
              CircleButton(
                  true, Icons.edit, 20.0, Color.fromRGBO(255, 255, 255, 0.6),
                  () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => HotelModify(
                              hotel: hotel,
                            )));
              }),
              CircleButton(true, Icons.exit_to_app, 20.0,
                  Color.fromRGBO(255, 255, 255, 0.6), () async {
                await _firebaseAuth.signOut();
                Navigator.of(context).pushNamed('/');
              }),
            ],
          ));
    } else {
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              CircleButton(
                  true, Icons.add, 20.0, Color.fromRGBO(255, 255, 255, 0.6),
                  () {
                File image;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HotelCreate()));
              }),
              CircleButton(true, Icons.exit_to_app, 20.0,
                  Color.fromRGBO(255, 255, 255, 0.6), () async {
                await _firebaseAuth.signOut();
                Navigator.of(context).pushNamed('/');
              })
            ],
          ));
    }
  }
}
