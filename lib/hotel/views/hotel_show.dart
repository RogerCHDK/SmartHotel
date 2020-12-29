import 'package:flutter/material.dart';
import 'package:hoteles/core/models/hotelModel.dart';
import 'package:hoteles/core/viewmodels/CRUDHotel.dart';
import 'package:hoteles/hotel/views/hotel_modify.dart';
import 'package:provider/provider.dart';

class HotelShow extends StatelessWidget {
  final Hotel hotel;
  HotelShow({@required this.hotel});
  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<CRUDHotel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles Hotel'),
        actions: <Widget>[
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.delete_forever),
            onPressed: () async {
              await hotelProvider.removeHotel(hotel.id);
              Navigator.pop(context);
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
                            hotel: hotel,
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
            hotel.nombre,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            hotel.colonia,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            hotel.calle,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                fontStyle: FontStyle.italic),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
