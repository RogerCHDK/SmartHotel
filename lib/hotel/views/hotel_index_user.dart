import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/hotelModel.dart';
import 'package:hoteles/core/services/menu_provider.dart';
import 'package:hoteles/core/viewmodels/CRUDHotel.dart';
import 'package:hoteles/core/viewmodels/CRUDUser.dart';
import 'package:hoteles/widgets/my_tab_bar.dart';
import 'package:provider/provider.dart';

import 'hotel_modify.dart';

class HotelIndexUser extends StatefulWidget {
  @override
  _HotelIndexUserState createState() => _HotelIndexUserState();
}

class _HotelIndexUserState extends State<HotelIndexUser> {
  FirebaseUser user;
  List<Hotel> hotel;

/*
  void initState() {
    super.initState();
    cargardatos();
  }

   cargardatos() async {
    user = await FirebaseAuth.instance.currentUser();
    print("Hola" + user.uid);
  }*/

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<CRUDHotel>(context);
    final userProvider = Provider.of<CRUDUser>(context);
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    return FutureBuilder(
      future: menuProvider.cargardatos(),
      builder: (context, datos) {
        return StreamBuilder(
            stream: hotelProvider.filtroHotel(datos.data.uid),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              hotel = snapshot.data.documents
                  .map((doc) => Hotel.fromMap(doc.data, doc.documentID))
                  .toList();
              print(hotel.isNotEmpty);
              if (hotel.isNotEmpty) {
                return Scaffold(
                  appBar: AppBar(
                    title: Center(child: Text('Hotel')),
                    automaticallyImplyLeading: false,
                    actions: <Widget>[
                      IconButton(
                        iconSize: 35,
                        icon: Icon(Icons.delete_forever),
                        onPressed: () async {
                          await hotelProvider.removeHotel(hotel[0].id);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (_) => MyTabBar()));
                        },
                      ),
                      IconButton(
                        iconSize: 35,
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => HotelModify(
                                        hotel: hotel[0],
                                      )));
                        },
                      )
                    ],
                  ),
                  body: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Hotel ${hotel[0].nombre}',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Hero(
                        tag: "h",
                        child: Image.asset(
                          'assets/img/hotel.jpg',
                          height: MediaQuery.of(context).size.height * 0.35,
                        ),
                      ),
                      Text(
                        'Dirección:',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        '${hotel[0].estado}, ${hotel[0].municipio}, Colonia ${hotel[0].colonia}, Calle ${hotel[0].calle} ',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              } else {
                return Scaffold(
                  appBar: AppBar(
                    title: Center(child: Text('Hotel')),
                    automaticallyImplyLeading: false,
                    actions: <Widget>[
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
                  body: Center(
                    child: RaisedButton(
                      splashColor: Colors.red,
                      onPressed: () {
                        Navigator.pushNamed(context, '/agregarHotel');
                      },
                      child: Text('Agregar Hotel',
                          style: TextStyle(color: Colors.white)),
                      color: Colors.blue,
                    ),
                  ),
                );
              }
            });
      },
    );
  }
}
