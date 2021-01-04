import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/hotelModel.dart';
import 'package:hoteles/core/viewmodels/CRUDHotel.dart';
import 'package:hoteles/hotel/widgets/HotelCard.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HotelIndex extends StatefulWidget {
  @override
  _HotelIndexState createState() => _HotelIndexState();
}

class _HotelIndexState extends State<HotelIndex> {
  List<Hotel> hoteles;

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<CRUDHotel>(
        context); //aqui mando a llamar a la instancia del modelo a usar
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        //este es el boton con la accion de llevarnos al formulario para cear productos
        onPressed: () {
          Navigator.pushNamed(context, '/agregarHotel');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Center(child: Text('Home')),
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
      body: Container(
        child: StreamBuilder(
            stream: hotelProvider
                .fetchHotelesAsStream(), //aqui estamos escuchando para que cada que haya un cambio en la base de datos se vea reflejado
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                hoteles = snapshot.data.documents
                    .map((doc) => Hotel.fromMap(doc.data, doc.documentID))
                    .toList();
                return ListView.builder(
                  itemCount: hoteles.length,
                  itemBuilder: (buildContext, index) =>
                      HotelCard(hotelDetails: hoteles[index]),
                );
              } else {
                return Text('fetching');
              }
            }),
      ),
    );
  }
}
