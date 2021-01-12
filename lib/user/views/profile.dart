import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/hotelModel.dart';
import 'package:hoteles/core/services/menu_provider.dart';
import 'package:hoteles/core/viewmodels/CRUDHotel.dart';
import 'package:hoteles/hotel/views/info_hotel.dart';
import 'package:hoteles/widgets/card_image_list.dart';
import 'package:hoteles/widgets/profile_background.dart';
import 'package:hoteles/widgets/profile_header.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  List<Hotel> hotel;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: menuProvider.cargardatos(),
        builder: (context, datos) {
          switch (datos.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              return cabecera(context, datos.data.uid);

            case ConnectionState.active:
              return cabecera(context, datos.data.uid);

            case ConnectionState.none:
              return CircularProgressIndicator();
            default:
              return cabecera(context, datos.data.uid);
          }
        });
  }

  Widget cabecera(BuildContext context, String id) {
    final hotelProvider = Provider.of<CRUDHotel>(context);
    return StreamBuilder(
        stream: hotelProvider.filtroHotel(id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              return infoHotel(snapshot, context, id);

            case ConnectionState.active:
              return infoHotel(snapshot, context, id);

            case ConnectionState.none:
              return CircularProgressIndicator();
            default:
              return infoHotel(snapshot, context, id);
          }
        });
  }

  Widget infoHotel(
      AsyncSnapshot<QuerySnapshot> aux, BuildContext context, String id) {
    hotel = aux.data.documents
        .map((doc) => Hotel.fromMap(doc.data, doc.documentID))
        .toList();
    if (hotel.isNotEmpty) {
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[
              ProfileHeader(id, hotel[0]),
              CardImageList(),
              InfoHotel(hotel)
            ],
          ),
        ],
      );
    } else {
      return Stack(
        children: <Widget>[
          ProfileBackground(),
          ListView(
            children: <Widget>[ProfileHeader(id, null)],
          ),
        ],
      );
    }
  }
}
