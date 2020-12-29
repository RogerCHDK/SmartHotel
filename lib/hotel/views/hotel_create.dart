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
                    border: InputBorder.none,
                    hintText: 'Nombre Hotel',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
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
                    border: InputBorder.none,
                    hintText: 'Calle',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor introduce la calle';
                    }
                  },
                  onSaved: (value) => calle = value),
              TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Colonia',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor introduce la colonia';
                    }
                  },
                  onSaved: (value) => colonia = value),
              SizedBox(
                height: 16,
              ),
              RaisedButton(
                splashColor: Colors.red,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await hotelProvider.addHotel(
                        Hotel(nombre: nombre, calle: calle, colonia: colonia));
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
