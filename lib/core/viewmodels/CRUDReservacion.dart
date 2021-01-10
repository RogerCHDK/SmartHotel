import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/reservacionModel.dart';
import 'package:hoteles/core/services/ApiReservacion.dart';
import 'package:hoteles/locator.dart';

class CRUDReservacion extends ChangeNotifier {
  ApiReservacion _api = locator<ApiReservacion>();

  List<Reservacion> reservacion;

  Future<List<Reservacion>> fetchReservaciones() async {
    var result = await _api.getDataCollection();
    reservacion = result.documents
        .map((doc) => Reservacion.fromMap(doc.data, doc.documentID))
        .toList();
    return reservacion;
  }

  Stream<QuerySnapshot> fetchReservacionesAsStream() {
    return _api.streamDataCollection();
  }

  Future<Reservacion> getReservacionById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Reservacion.fromMap(doc.data, doc.documentID);
  }

  Future removeReservacion(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateReservacion(Reservacion data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addReservacion(Reservacion data) async {
    var result = await _api.addDocument(data.toJson());
    return;
  }

  Stream<QuerySnapshot> filtroCorreo(String filtro) {
    return _api.filtroNombre(filtro);
  }
}
