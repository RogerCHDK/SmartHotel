import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/habitacionModel.dart';
import 'package:hoteles/core/services/menu_provider.dart';
import 'package:hoteles/core/viewmodels/CRUDHabitacion.dart';
import 'package:hoteles/habitacion/widgets/HabitacionCard.dart';
import 'package:hoteles/user/widgets/gradient_back.dart';
import 'package:hoteles/widgets/title_header.dart';
import 'package:provider/provider.dart';

class HabitacionIndex extends StatefulWidget {
  @override
  _HabitacionIndexState createState() => _HabitacionIndexState();
}

class _HabitacionIndexState extends State<HabitacionIndex> {
  List<Habitacion> habitaciones;
  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: menuProvider.cargardatos(),
        builder: (context, datos) {
          switch (datos.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              return hotelInformacion(context, datos.data.uid);

            case ConnectionState.active:
              return hotelInformacion(context, datos.data.uid);

            case ConnectionState.none:
              return CircularProgressIndicator();
            default:
              return hotelInformacion(context, datos.data.uid);
          }
        });
  }

  Widget hotelInformacion(BuildContext context, String id) {
    final habitacionProvider = Provider.of<CRUDHabitacion>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        //este es el boton con la accion de llevarnos al formulario para cear productos
        onPressed: () {
          Navigator.pushNamed(context, '/agregarHabitacion');
        },
        child: Icon(Icons.add),
      ),
      body: Stack(children: <Widget>[
        GradientBack(
          height: 300.0,
        ),
        Container(
            padding: EdgeInsets.only(top: 25.0, left: 5.0),
            child: Flexible(
                child: Container(
              padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 10.0),
              child: TitleHeader(title: "Habitación"),
            ))),
        Container(
          margin: EdgeInsets.only(top: 120.0, bottom: 20.0),
          child: StreamBuilder(
              stream: habitacionProvider.filtroHabitacion(
                  id), //aqui estamos escuchando para que cada que haya un cambio en la base de datos se vea reflejado
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  habitaciones = snapshot.data.documents
                      .map(
                          (doc) => Habitacion.fromMap(doc.data, doc.documentID))
                      .toList();
                  return ListView.builder(
                    itemCount: habitaciones.length,
                    itemBuilder: (buildContext, index) =>
                        HabitacionCard(habitacionDetails: habitaciones[index]),
                  );
                } else {
                  return Text('fetching');
                }
              }),
        )
      ]),
    );
  }
}
