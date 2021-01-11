import 'package:flutter/material.dart';
import 'package:hoteles/widgets/floating_action_button_green.dart';

class CardImageWithFabIcon extends StatelessWidget {
  final double height;
  final double width;
  double left;
  final String pathImage;
  final VoidCallback onPressedFabIcon;
  final IconData iconData;

  CardImageWithFabIcon(
      {Key key,
      @required this.pathImage,
      @required this.width,
      @required this.height,
      @required this.onPressedFabIcon,
      @required this.iconData,
      this.left});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();

    final card = Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(
        left: left,
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(pathImage),
          ),
          borderRadius: BorderRadius.all(Radius.circular(
              10.0)), //la primera instruccion indica que se va aplicar a toda las esquinas de la imagen y la segunda hace que las esquinas de la imagen esten redondeadas
          shape: BoxShape.rectangle, //le doy forma al contenedor
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              blurRadius: 15.0, //es el degradado
              offset: Offset(0.0, 7.0), //la posicion de la sombre en x and y
            )
          ]),
    );

    return Stack(
      alignment: Alignment(0.9, 1.1),
      children: <Widget>[
        card,
        FloatingActionButtonGreen(
          iconData: iconData,
          onPressed: onPressedFabIcon,
        )
      ],
    );
  }
}
