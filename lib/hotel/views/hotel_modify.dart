import 'package:firebase_auth/firebase_auth.dart';
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
  String municipio;
  String estado;
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Nombre Hotel',
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
                  initialValue: widget.hotel.colonia,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Colonia',
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
                  initialValue: widget.hotel.calle,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Calle',
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
                  initialValue: widget.hotel.municipio,
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
                  initialValue: widget.hotel.estado,
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
                    await hotelProvider.updateHotel(
                        Hotel(
                          nombre: nombre,
                          calle: calle,
                          colonia: colonia,
                          municipio: municipio,
                          estado: estado,
                          id_administrador: user.uid,
                        ),
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
