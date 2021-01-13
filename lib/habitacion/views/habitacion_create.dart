import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/habitacionModel.dart';
import 'package:hoteles/core/viewmodels/CRUDHabitacion.dart';
import 'package:hoteles/user/widgets/gradient_back.dart';
import 'package:hoteles/widgets/button_purple.dart';
import 'package:hoteles/widgets/card_image.dart';
import 'package:hoteles/widgets/title_header.dart';
import 'package:provider/provider.dart';

class HabitacionCreate extends StatefulWidget {
  @override
  _HabitacionCreateState createState() => _HabitacionCreateState();
}

class _HabitacionCreateState extends State<HabitacionCreate> {
  final _formKey = GlobalKey<FormState>();
  String tipo_habitacion;
  String numero_habitacion;
  String piso;
  String vista;
  String precio;

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
    final habitacionProvider = Provider.of<CRUDHabitacion>(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
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
                child: TitleHeader(title: "Crear habitacion"),
              ))
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 120.0, bottom: 20.0),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CardImageWithFabIcon(
                    pathImage: "assets/img/habitacion1.jpg",
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
                      child: Column(children: <Widget>[
                        TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                hintText: 'Tipo Habitacion',
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Tipo Habitacion'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor introduce el tipo de habitacion';
                              }
                            },
                            onSaved: (value) => tipo_habitacion = value),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                hintText: 'Número habitación',
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Número habitación'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor introduce el número de la habitacion';
                              }
                            },
                            onSaved: (value) => numero_habitacion = value),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                hintText: 'Introduce el piso',
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Piso'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor introduce la calle';
                              }
                            },
                            onSaved: (value) => piso = value),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                hintText: 'Introduce la vista de la habitacion',
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Vista'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor introduce la vista';
                              }
                            },
                            onSaved: (value) => vista = value),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                hintText: 'Introduce el precio',
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Precio'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Por favor introduce el precio';
                              }
                            },
                            onSaved: (value) => precio = value),
                        Container(
                          width: 350.0,
                          child: ButtonPurple(
                            buttonText: "Agregar habitacion",
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                await habitacionProvider
                                    .addHabitacion(Habitacion(
                                  numero_habitacion: numero_habitacion,
                                  tipo_habitacion: tipo_habitacion,
                                  vista: vista,
                                  piso: piso,
                                  precio: precio,
                                  id_administrador: user.uid,
                                  status: "disponible",
                                ));
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                      ]),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
