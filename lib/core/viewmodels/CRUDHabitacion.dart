import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/habitacionModel.dart';
import 'package:hoteles/core/services/ApiHabitacion.dart';
import 'package:hoteles/locator.dart';

class CRUDHabitacion extends ChangeNotifier {
  ApiHabitacion _api = locator<ApiHabitacion>();

  List<Habitacion> habitacion;

  Future<List<Habitacion>> fetchHabitacion() async {
    var result = await _api.getDataCollection();
    habitacion = result.documents
        .map((doc) => Habitacion.fromMap(doc.data, doc.documentID))
        .toList();
    return habitacion;
  }

  Stream<QuerySnapshot> fetchHabitacionAsStream() {
    return _api.streamDataCollection();
  }

  Future<Habitacion> getHabitacionById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Habitacion.fromMap(doc.data, doc.documentID);
  }

  Future removeHabitacion(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateHabitacion(Habitacion data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addHabitacion(Habitacion data) async {
    var result = await _api.addDocument(data.toJson());

    return;
  }

  Stream<QuerySnapshot> filtroHabitacion(String filtro) {
    return _api.filtroNombre(filtro);
  }
}
