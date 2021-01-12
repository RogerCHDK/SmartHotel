import 'package:flutter/material.dart';
import 'package:hoteles/core/models/hotelModel.dart';
import 'package:hoteles/widgets/floating_action_button_green.dart';

class InfoHotel extends StatelessWidget {
  List<Hotel> hotel;
  InfoHotel(this.hotel);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
            children: <Widget>[direccion],
          )),
    );
    return Stack(
      alignment: Alignment(0.0, 0.8),
      children: <Widget>[
        card,
      ],
    );
  }
}
