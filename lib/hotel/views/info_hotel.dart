import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/hotelModel.dart';
import 'package:hoteles/core/services/menu_provider.dart';
import 'package:hoteles/core/viewmodels/CRUDHotel.dart';
import 'package:hoteles/widgets/floating_action_button_green.dart';
import 'package:hoteles/widgets/my_tab_bar.dart';
import 'package:provider/provider.dart';

class InfoHotel extends StatelessWidget {
  List<Hotel> hotel;
  @override
  Widget build(BuildContext context) {
    FirebaseUser user;
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    return Container(
      child: FutureBuilder(
        future: menuProvider.cargardatos(),
        builder: (context, datos) {
          switch (datos.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              return infoHotel(context, datos.data.uid);

            case ConnectionState.active:
              return infoHotel(context, datos.data.uid);

            case ConnectionState.none:
              return CircularProgressIndicator();
            default:
              return infoHotel(context, datos.data.uid);
          }
        },
      ),
    );
  }

  Widget infoHotel(BuildContext context, String id) {
    final hotelProvider = Provider.of<CRUDHotel>(context);
    return StreamBuilder(
        stream: hotelProvider.filtroHotel(id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              return cardHotel(snapshot, context);

            case ConnectionState.active:
              return cardHotel(snapshot, context);

            case ConnectionState.none:
              return CircularProgressIndicator();
            default:
              return cardHotel(snapshot, context);
          }
        });
  }

  Widget cardHotel(AsyncSnapshot<QuerySnapshot> aux, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    hotel = aux.data.documents
        .map((doc) => Hotel.fromMap(doc.data, doc.documentID))
        .toList();
    if (hotel.isNotEmpty) {
      final nombre = Text(
        'Hotel ${hotel[0].nombre}',
        style: TextStyle(
            fontFamily: 'Lato', fontSize: 32.0, fontWeight: FontWeight.bold),
      );

      final direccion = Text(
        '${hotel[0].estado}, ${hotel[0].municipio}, Colonia ${hotel[0].colonia}, Calle ${hotel[0].calle} ',
        style: TextStyle(
            fontFamily: 'Lato', fontSize: 24.0, fontWeight: FontWeight.bold),
      );

      final card = Container(
        width: screenWidth * 0.65,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black38,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 5.0))
            ]),
        child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[nombre, direccion],
            )),
      );
      return Stack(
        alignment: Alignment(0.0, 0.8),
        children: <Widget>[
          card,
          FloatingActionButtonGreen(
            iconData: Icons.delete,
            onPressed: null,
          )
        ],
      );
    } else {
      return Center(
        child: RaisedButton(
          splashColor: Colors.red,
          onPressed: () {
            Navigator.pushNamed(context, '/agregarHotel');
          },
          child: Text('Agregar Hotel', style: TextStyle(color: Colors.white)),
          color: Colors.blue,
        ),
      );
    }
  }
}
