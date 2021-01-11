import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/hotel/views/hotel_create.dart';
import 'package:hoteles/widgets/circle_button.dart';

class ButtonsBar extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            CircleButton(
                true, Icons.add, 20.0, Color.fromRGBO(255, 255, 255, 0.6), () {
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
