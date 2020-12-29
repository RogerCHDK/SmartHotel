import 'package:flutter/material.dart';
import 'package:hoteles/core/models/hotelModel.dart';
import 'package:hoteles/core/viewmodels/CRUDHotel.dart';
import 'package:provider/provider.dart';

class HotelModify extends StatefulWidget {
  final Hotel hotel;
  HotelModify({@required this.hotel});

  @override
  _HotelModifyState createState() => _HotelModifyState();
}

class _HotelModifyState extends State<HotelModify> {
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
          child: Text('Modificar Hotel'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  initialValue: widget.hotel.nombre,
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
                  initialValue: widget.hotel.calle,
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
                  initialValue: widget.hotel.colonia,
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
                    await hotelProvider.updateHotel(
                        Hotel(nombre: nombre, calle: calle, colonia: colonia),
                        widget.hotel.id);
                    Navigator.pop(context);
                  }
                },
                child: Text('Modificar Hotel',
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
