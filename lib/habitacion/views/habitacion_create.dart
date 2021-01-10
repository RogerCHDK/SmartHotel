import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/habitacionModel.dart';
import 'package:hoteles/core/viewmodels/CRUDHabitacion.dart';
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
      appBar: AppBar(
        title: Center(
          child: Text('Crear Habitacion'),
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
                      hintText: 'Tipo Habitacion',
                      filled: true,
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
                      filled: true,
                      labelText: 'Precio'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor introduce el precio';
                    }
                  },
                  onSaved: (value) => precio = value),
              SizedBox(
                height: 16,
              ),
              RaisedButton(
                splashColor: Colors.red,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await habitacionProvider.addHabitacion(Habitacion(
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
                child: Text('Agregar Habitacion',
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
