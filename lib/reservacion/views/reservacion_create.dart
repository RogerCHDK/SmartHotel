import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/habitacionModel.dart';
import 'package:hoteles/core/models/reservacionModel.dart';
import 'package:hoteles/core/viewmodels/CRUDHabitacion.dart';
import 'package:hoteles/core/viewmodels/CRUDReservacion.dart';
import 'package:hoteles/widgets/my_tab_bar.dart';
import 'package:provider/provider.dart';

class ReservacionCreate extends StatefulWidget {
  @override
  _ReservacionCreateState createState() => _ReservacionCreateState();
}

class _ReservacionCreateState extends State<ReservacionCreate> {
  final _formKey = GlobalKey<FormState>();
  String correo;
  String horas;
  String dias;

  String selectHabitacion;

  List<Habitacion> habitaciones;
  List<DropdownMenuItem<String>> dropdownItems;

  List<DropdownMenuItem<String>> buildDropDownItems(
      List<Habitacion> habitaciones) {
    List<DropdownMenuItem<String>> items = List();
    for (Habitacion habitacion in habitaciones) {
      items.add(DropdownMenuItem(
        value: habitacion.id,
        child: Text(
          'Habitacion ${habitacion.numero_habitacion} ${habitacion.tipo_habitacion}',
          style: TextStyle(
              fontFamily: 'Lato', fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ));
    }
    return items;
  }

  onChangeDropdownItem(String auxiliar) {
    setState(() {
      selectHabitacion = auxiliar;
    });
  }

  @override
  Widget build(BuildContext context) {
    final habitacionProvider = Provider.of<CRUDHabitacion>(context);
    final reservacionProvider = Provider.of<CRUDReservacion>(context);
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    final combobox_habitaciones = StreamBuilder(
      stream: habitacionProvider.fetchHabitacionAsStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          habitaciones = snapshot.data.documents
              .map((doc) => Habitacion.fromMap(doc.data, doc.documentID))
              .toList();

          dropdownItems = buildDropDownItems(habitaciones);
          return DropdownButton<String>(
            //el combobox de nombre
            value: selectHabitacion,
            items: dropdownItems,
            onChanged: onChangeDropdownItem,
          );
        } else {
          return Text('fetching');
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Reservacion")),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            iconSize: 35,
            icon: Icon(Icons.input),
            onPressed: () async {
              await _firebaseAuth.signOut();
              Navigator.of(context).pushNamed('/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Introduce el correo',
                      filled: true,
                      labelText: 'Correo'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor introduce el correo';
                    }
                  },
                  onSaved: (value) => correo = value),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Introduce las horas',
                      filled: true,
                      labelText: 'Horas'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor introduce la hora';
                    }
                  },
                  onSaved: (value) => horas = value),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Introduce los dias',
                      filled: true,
                      labelText: 'Dias'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Por favor introduce los dias';
                    }
                  },
                  onSaved: (value) => dias = value),
              SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Habitacion",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  combobox_habitaciones,
                ],
              ),
              SizedBox(
                height: 16,
              ),
              RaisedButton(
                splashColor: Colors.red,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await reservacionProvider.addReservacion(Reservacion(
                      id_habitacion: selectHabitacion,
                      correo: correo,
                      horas: horas,
                      dias: dias,
                    ));
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (_) => MyTabBar()));
                  }
                },
                child: Text('Agregar', style: TextStyle(color: Colors.white)),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
