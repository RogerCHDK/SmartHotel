import 'package:flutter/material.dart';
import 'package:hoteles/user/widgets/user_info.dart';
import 'package:hoteles/widgets/button_bar.dart';

class ProfileHeaderUser extends StatelessWidget {
  String usuario_id;
  String numero;
  ProfileHeaderUser(this.usuario_id, this.numero);
  @override
  Widget build(BuildContext context) {
    final title = Text(
      'Habitacion ${numero}',
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
        ],
      ),
    );
  }
}
