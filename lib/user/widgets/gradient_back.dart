import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget {
  String title = "Popular";
  double height = 0.0;

  GradientBack(
      {Key key, this.height}); //height = null, significa un full screen
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();

    double screenHeight = MediaQuery.of(context)
        .size
        .height; //Estamos obteniendo el tamaño de la altura de cualquier celular
    double screenWidht = MediaQuery.of(context).size.width;

    if (height == null) {
      height = screenHeight;
    }

    return Container(
      width: screenWidht,
      height: height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFF4268D3), //Color mas claro
                Color(0xFF584CD1) //Color mas obscuro
              ],
              begin: FractionalOffset(
                  0.2, 0.0), //orientacion de que tanto quiero el gradiente
              end: FractionalOffset(1.0,
                  0.6), //hasta donde quiero que llegue el color mas obscuro
              stops: [
                0.0,
                0.6
              ], //Orientacion del gradiente,puede ir de arriba hacia abajo
              tileMode: TileMode
                  .clamp //color de relleno en caso de que no cargue el gradiente
              )),
      child: FittedBox(
        fit: BoxFit.none,
        alignment: Alignment(-1.5, -0.8),
        child: Container(
          width: screenHeight,
          height: screenHeight,
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            borderRadius: BorderRadius.circular(screenHeight / 2),
          ),
        ),
      ),
      /*Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: "Lato",
            fontWeight: FontWeight.bold),
      ),*/
      //alignment: Alignment(-0.9, -0.6),
    );
  }
}
