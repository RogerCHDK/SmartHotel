import 'package:flutter/material.dart';
import 'package:hoteles/core/models/userModel.dart';
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
              return usuarioInfo(user.data);

            case ConnectionState.active:
              return usuarioInfo(user.data);

            case ConnectionState.none:
              return CircularProgressIndicator();
            default:
              return usuarioInfo(user.data);
          }
        });
  }

  Widget usuarioInfo(User usuario) {
    final userPhotoAdmon = Container(
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
                  "https://image.freepik.com/vector-gratis/perfil-hombre-dibujos-animados_18591-58483.jpg") //traer una foto de internet
              )),
    );

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
                  "https://www.lapi.com.mx/image.ashx?s=57067&im=115316&t=p") //traer una foto de internet
              )),
    );

    final userInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
                "${usuario.nombre} ${usuario.apellido_p} ${usuario.apellido_m}",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Lato',
                ))),
        Text(usuario.correo,
            style: TextStyle(
                fontSize: 15.0, color: Colors.white54, fontFamily: 'Lato')),
      ],
    );

    if (usuario.tipo.compareTo("Administrador") == 0) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
        child: Row(
          children: <Widget>[userPhotoAdmon, userInfo],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
        child: Row(
          children: <Widget>[userPhoto, userInfo],
        ),
      );
    }
  }
}
