import 'package:flutter/material.dart';
import 'package:hoteles/widgets/card_image.dart';

class CardImageList extends StatelessWidget {
  String imagen1 = "assets/img/river.jpeg";
  String imagen2 = "assets/img/mountain_stars.jpeg";
  String imagen3 = "assets/img/beach.jpeg";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();

    double width = 300.0;
    double height = 350.0;
    double left = 20.0;

    return Container(
      height: 250.0,
      child: ListView(
        padding: EdgeInsets.all(25.0),
        scrollDirection:
            Axis.horizontal, //hago que el scroll se haga de manera horizontal
        children: <Widget>[
          CardImageWithFabIcon(
            pathImage: imagen1,
            iconData: Icons.favorite_border,
            width: width,
            height: height,
            left: left,
          ),
          CardImageWithFabIcon(
            pathImage: imagen2,
            iconData: Icons.favorite_border,
            width: width,
            height: height,
            left: left,
          ),
          CardImageWithFabIcon(
            pathImage: imagen3,
            iconData: Icons.favorite_border,
            width: width,
            height: height,
            left: left,
          ),
        ],
      ),
    );
  }
}
