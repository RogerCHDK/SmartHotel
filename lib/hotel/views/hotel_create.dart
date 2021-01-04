import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/hotelModel.dart';
import 'package:hoteles/core/viewmodels/CRUDHotel.dart';
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
      appBar: AppBar(
        title: Center(
          child: Text('Agregar Hotel'),
        ),
      ),
      body: Padding(
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
                      labelText: 'Estado'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor introduce el estado';
                    }
                  },
                  onSaved: (value) => estado = value),
              SizedBox(
                height: 16,
              ),
              RaisedButton(
                splashColor: Colors.red,
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
                child: Text('Agregar Hotel',
                    style: TextStyle(color: Colors.white)),
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
