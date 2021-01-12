import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/habitacionModel.dart';
import 'package:hoteles/core/models/hotelModel.dart';
import 'package:hoteles/core/models/reservacionModel.dart';
import 'package:hoteles/core/services/menu_provider.dart';
import 'package:hoteles/core/viewmodels/CRUDHabitacion.dart';
import 'package:hoteles/core/viewmodels/CRUDHotel.dart';
import 'package:hoteles/core/viewmodels/CRUDReservacion.dart';
import 'package:hoteles/reservacion/views/info_reservacion.dart';
import 'package:hoteles/user/views/profile_header_user.dart';
import 'package:hoteles/widgets/card_image_list.dart';
import 'package:hoteles/widgets/circle_button.dart';
import 'package:hoteles/widgets/my_tab_bar.dart';
import 'package:hoteles/widgets/profile_background.dart';
import 'package:provider/provider.dart';

class HabitacionShowUser extends StatefulWidget {
  @override
  _HabitacionShowUserState createState() => _HabitacionShowUserState();
}

class _HabitacionShowUserState extends State<HabitacionShowUser> {
  FirebaseUser user;
  List<Reservacion> reservacion;
  String habitacion;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final habitacionProvider = Provider.of<CRUDHabitacion>(context);
    return FutureBuilder(
      future: menuProvider.cargardatos(),
      builder: (context, datos) {
        switch (datos.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.done:
            return getReservacion(context, datos.data.email, datos.data.uid);

          case ConnectionState.active:
            return getReservacion(context, datos.data.email, datos.data.uid);

          case ConnectionState.none:
            return CircularProgressIndicator();
          default:
            return getReservacion(context, datos.data.email, datos.data.uid);
        }
      },
    );
  }

  Widget getReservacion(BuildContext context, String email, String usuario) {
    final reservacionProvider = Provider.of<CRUDReservacion>(context);
    List<Reservacion> reservacion;
    return StreamBuilder(
        stream: reservacionProvider.filtroCorreo(email),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              return getHabitacion(context, snapshot, usuario);

            case ConnectionState.active:
              return getHabitacion(context, snapshot, usuario);

            case ConnectionState.none:
              return CircularProgressIndicator();
            default:
              return getHabitacion(context, snapshot, usuario);
          }
        });
  }

  Widget getHabitacion(
      BuildContext context, AsyncSnapshot<QuerySnapshot> aux, String usuario) {
    final habitacionP = Provider.of<CRUDHabitacion>(context);
    reservacion = aux.data.documents
        .map((doc) => Reservacion.fromMap(doc.data, doc.documentID))
        .toList();
    return FutureBuilder(
      future: habitacionP.getHabitacionById(reservacion.first.id_habitacion),
      builder: (context, datos) {
        switch (datos.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          case ConnectionState.done:
            return showInformacion(datos, reservacion.first, usuario);

          case ConnectionState.active:
            return showInformacion(datos, reservacion.first, usuario);

          case ConnectionState.none:
            return CircularProgressIndicator();
          default:
            return showInformacion(datos, reservacion.first, usuario);
        }
      },
    );
  }

  Widget showInformacion(AsyncSnapshot<Habitacion> habitacion,
      Reservacion reservacion, String usuario) {
    return Stack(
      children: <Widget>[
        ProfileBackground(),
        ListView(
          children: <Widget>[
            ProfileHeaderUser(usuario, habitacion.data.numero_habitacion),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                child: Row(
                  children: <Widget>[
                    CircleButton(true, Icons.exit_to_app, 20.0,
                        Color.fromRGBO(255, 255, 255, 0.6), () async {
                      await _firebaseAuth.signOut();
                      Navigator.of(context).pushNamed('/');
                    }),
                  ],
                )),
            CardImageList(),
            InfoReservacion(habitacion.data, reservacion),
          ],
        ),
      ],
    );
  }
}
