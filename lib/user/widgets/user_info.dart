import 'package:flutter/material.dart';
import 'package:hoteles/core/services/menu_provider.dart';
import 'package:hoteles/core/viewmodels/CRUDUser.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  String usuario_id;
  UserInfo(this.usuario_id);
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<CRUDUser>(context);
    return FutureBuilder(
        future: userProvider.getUserById(usuario_id),
        builder: (context, user) {
          switch (user.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              return usuarioInfo(user.data.nombre, user.data.correo);

            case ConnectionState.active:
              return usuarioInfo(user.data.nombre, user.data.correo);

            case ConnectionState.none:
              return CircularProgressIndicator();
            default:
              return usuarioInfo(user.data.nombre, user.data.correo);
          }
        });
  }

  Widget usuarioInfo(String nombre, String correo) {
    final userPhoto = Container(
      width: 90.0,
      height: 90.0,
      margin: EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.white, width: 2.0, style: BorderStyle.solid),
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover,
              //image: AssetImage(user.photoURL)
              image: NetworkImage(
                  "https://holatelcel.com/wp-content/uploads/2020/07/como-descargar-la-foto-de-perfil-de-whatsapp-de-un-contacto.png") //traer una foto de internet
              )),
    );

    final userInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(nombre,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Lato',
                ))),
        Text(correo,
            style: TextStyle(
                fontSize: 15.0, color: Colors.white30, fontFamily: 'Lato')),
      ],
    );

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
      child: Row(
        children: <Widget>[userPhoto, userInfo],
      ),
    );
  }
}
