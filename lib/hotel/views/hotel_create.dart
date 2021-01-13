import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/hotelModel.dart';
import 'package:hoteles/core/viewmodels/CRUDHotel.dart';
import 'package:hoteles/user/widgets/gradient_back.dart';
import 'package:hoteles/widgets/button_purple.dart';
import 'package:hoteles/widgets/card_image.dart';
import 'package:hoteles/widgets/title_header.dart';
import 'package:provider/provider.dart';

class HotelCreate extends StatefulWidget {
  @override
  _HotelCreateState createState() => _HotelCreateState();
}

class _HotelCreateState extends State<HotelCreate> {
  final _formKey = GlobalKey<FormState>();
  String nombre;
  String calle;
  String colonia;
  String municipio;
  String estado;
  String habitaciones = "0";
  FirebaseUser user;
  void initState() {
    super.initState();
    someMethod();
  }

  someMethod() async {
    user = await FirebaseAuth.instance.currentUser();
    print("Hola" + user.uid);
  }

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<CRUDHotel>(context);

    return Scaffold(
      body: Stack(children: <Widget>[
        GradientBack(
          height: 300.0,
        ),
        Row(
          //Appbar
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 25.0, left: 5.0),
              child: SizedBox(
                height: 45.0,
                width: 45.0,
                child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 45,
                    ),
                    onPressed: () {
                      Navigator.pop(
                          context); //con este metodo regreso a la pantalla anterior
                    }),
              ),
            ),
            Flexible(
                child: Container(
              padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 10.0),
              child: TitleHeader(title: "Crear Hotel"),
            ))
          ],
        ),
        Container(
            margin: EdgeInsets.only(top: 120.0, bottom: 20.0),
            child: ListView(children: [
              Container(
                alignment: Alignment.center,
                child: CardImageWithFabIcon(
                  pathImage: "assets/img/hotel.jpg",
                  iconData: Icons.camera_alt,
                  width: 350.0,
                  height: 250.0,
                  left: 0,
                  onPressedFabIcon: null,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintText: 'Nombre del Hotel',
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Hotel'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor introduce el nombre del hotel';
                            }
                          },
                          onSaved: (value) => nombre = value),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintText: 'Nombre de la colonia',
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Colonia'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor introduce la colonia';
                            }
                          },
                          onSaved: (value) => colonia = value),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintText: 'Nombre de la calle',
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Calle'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor introduce la calle';
                            }
                          },
                          onSaved: (value) => calle = value),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintText: 'Nombre del municipio',
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Municipio'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor introduce el municipio';
                            }
                          },
                          onSaved: (value) => municipio = value),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              hintText: 'Nombre del estado',
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Estado'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor introduce el estado';
                            }
                          }, 
                          onSaved: (value) => estado = value),
                      Container(
                        width: 350.0,
                        child: ButtonPurple(
                          buttonText: "Agregar hotel",
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              await hotelProvider.addHotel(Hotel(
                                nombre: nombre,
                                calle: calle,
                                colonia: colonia,
                                municipio: municipio,
                                estado: estado,
                                num_habitaciones: habitaciones,
                                id_administrador: user.uid,
                              ));
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]))
      ]),
    );
  }
}
