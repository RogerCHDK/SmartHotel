import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/habitacionModel.dart';
import 'package:hoteles/core/services/menu_provider.dart';
import 'package:hoteles/core/viewmodels/CRUDHabitacion.dart';
import 'package:hoteles/habitacion/widgets/HabitacionCard.dart';
import 'package:provider/provider.dart';

class HabitacionIndex extends StatefulWidget {
  @override
  _HabitacionIndexState createState() => _HabitacionIndexState();
}

class _HabitacionIndexState extends State<HabitacionIndex> {
  List<Habitacion> habitaciones;
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
      floatingActionButton: FloatingActionButton(
        //este es el boton con la accion de llevarnos al formulario para cear productos
        onPressed: () {
          Navigator.pushNamed(context, '/agregarHabitacion');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Center(child: Text('Habitacion')),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: FutureBuilder(
            future: menuProvider.cargardatos(),
            builder: (context, datos) {
              return StreamBuilder(
                  stream: habitacionProvider.filtroHabitacion(datos.data
                      .uid), //aqui estamos escuchando para que cada que haya un cambio en la base de datos se vea reflejado
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      habitaciones = snapshot.data.documents
                          .map((doc) =>
                              Habitacion.fromMap(doc.data, doc.documentID))
                          .toList();
                      return ListView.builder(
                        itemCount: habitaciones.length,
                        itemBuilder: (buildContext, index) => HabitacionCard(
                            habitacionDetails: habitaciones[index]),
                      );
                    } else {
                      return Text('fetching');
                    }
                  });
            }),
      ),
    );
  }
}
