import 'package:flutter/material.dart';
import 'package:hoteles/hotel/views/info_hotel.dart';
import 'package:hoteles/widgets/card_image_list.dart';
import 'package:hoteles/widgets/profile_background.dart';
import 'package:hoteles/widgets/profile_header.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ProfileBackground(),
        ListView(
          children: <Widget>[ProfileHeader(), CardImageList(), InfoHotel()],
        ),
      ],
    );
  }
}
