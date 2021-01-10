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
import 'package:hoteles/widgets/my_tab_bar.dart';
import 'package:provider/provider.dart';

class HabitacionShowUser extends StatefulWidget {
  @override
  _HabitacionShowUserState createState() => _HabitacionShowUserState();
}

class _HabitacionShowUserState extends State<HabitacionShowUser> {
  FirebaseUser user;
  List<Reservacion> reservacion;
  String habitacion;

  @override
  Widget build(BuildContext context) {
    final habitacionProvider = Provider.of<CRUDHabitacion>(context);

    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Mi Habitacion")),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.input),
            onPressed: () async {
              await _firebaseAuth.signOut();
              Navigator.of(context).pushNamed('/');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: menuProvider.cargardatos(),
        builder: (context, datos) {
          return getReservacion(context, datos.data.email);
        },
      ),
    );

    /*return FutureBuilder(
      future: menuProvider.cargardatos(),
      builder: (context, datos) {
        return getReservacion(context, datos.data.email);
      },
    );*/
  }

  Widget getReservacion(BuildContext context, String email) {
    final reservacionProvider = Provider.of<CRUDReservacion>(context);
    List<Reservacion> reservacion;
    return StreamBuilder(
        stream: reservacionProvider.filtroCorreo(email),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          reservacion = snapshot.data.documents
              .map((doc) => Reservacion.fromMap(doc.data, doc.documentID))
              .toList();
          return getHabitacion(context, reservacion.first.id_habitacion,
              reservacion.first.dias, reservacion.first.horas);
        });
  }

  Widget getHabitacion(
      BuildContext context, String id, String dias, String horas) {
    final habitacionP = Provider.of<CRUDHabitacion>(context);
    return FutureBuilder(
      future: habitacionP.getHabitacionById(id),
      builder: (context, datos) {
        habitacion = datos.data.tipo_habitacion;
        return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: "he",
                child: Image.asset(
                  'assets/img/habitacion.jpg',
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
              ),
              Text(
                'Número de habitación: ${datos.data.numero_habitacion}',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Tipo de habitación: ${datos.data.tipo_habitacion}',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Piso de la habitación: ${datos.data.piso}',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Vista de la habitación: ${datos.data.vista}',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Precio de la habitación: ${datos.data.precio}',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Dias: ${dias}',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Horas: ${horas}',
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
            ]);
      },
    );
  }
}
