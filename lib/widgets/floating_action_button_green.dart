import 'package:flutter/material.dart';

class FloatingActionButtonGreen extends StatefulWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  FloatingActionButtonGreen(
      {Key key, @required this.iconData, @required this.onPressed});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //throw UnimplementedError();
    return _FloatingActionButtonGreen();
  }
}

class _FloatingActionButtonGreen extends State<FloatingActionButtonGreen> {
  bool bandera = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return FloatingActionButton(
      backgroundColor: Color(0xFF11DA53),
      mini: true,
      tooltip: "Fav", //cuando alguien se posiciona sobre el aparece el mensaje
      onPressed: widget.onPressed,
      child: Icon(widget.iconData),
      heroTag: null,
    );
  }

  void onPressedFav() {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Favorito 3"),
    ));

    setState(() {
      this.bandera = !this
          .bandera; //le pone un estado a la bandera, en vez de estar reseteando la aplicacion
    });
  }

  IconData mi_metodo() {
    if (this.bandera) {
      return Icons.favorite;
    } else {
      return Icons.favorite_border;
    }
  }
}
