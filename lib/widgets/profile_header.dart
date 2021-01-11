import 'package:flutter/material.dart';
import 'package:hoteles/user/widgets/user_info.dart';
import 'package:hoteles/widgets/button_bar.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = Text(
      'Hotel',
      style: TextStyle(
          fontFamily: 'Lato',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30.0),
    );

    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[title],
          ),
          UserInfo(), //le pasamos el objeto que contiene ya los datos del usuario
          ButtonsBar()
        ],
      ),
    );
  }
}
