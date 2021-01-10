import 'package:flutter/material.dart';

class ButtonGreen extends StatefulWidget {
  double width = 0.0, height = 0.0;
  final String text;
  final VoidCallback
      onPressed; //es una variable que puede recibir una funcion como parametro
  ButtonGreen(
      {Key key,
      @required this.text,
      @required this.onPressed,
      this.height,
      this.width}); //constructor con argumentos con nombre
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //throw UnimplementedError();
    return _ButtonGreen();
  }
}

class _ButtonGreen extends State<ButtonGreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return InkWell(
      onTap: widget
          .onPressed, //poniendo widget. podemos acceder a las propiedades de la otra clase
      child: Container(
        margin: EdgeInsets.only(
          top: 30.0,
          left: 20.0,
          right: 20.0,
        ),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: LinearGradient(
            colors: [
              Color(0xFFa7ff84), //color de arriba
              Color(0xFF1cbb78) //color de abajo
            ],
            begin: FractionalOffset(0.2, 0.0),
            end: FractionalOffset(1.0, 0.6),
            stops: [0.0, 0.6],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
                fontSize: 18.0, fontFamily: "Lato", color: Colors.white),
          ),
        ),
      ),
    );
  }
}
