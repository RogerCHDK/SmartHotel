import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/hotelModel.dart';
import 'package:hoteles/core/services/Api.dart';
import 'package:hoteles/locator.dart';

class CRUDHotel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Hotel> hoteles;

  Future<List<Hotel>> fetchHoteles() async {
    var result = await _api.getDataCollection();
    hoteles = result.documents
        .map((doc) => Hotel.fromMap(doc.data, doc.documentID))
        .toList();
    return hoteles;
  }

  Stream<QuerySnapshot> fetchHotelesAsStream() {
    return _api.streamDataCollection();
  }

  Future<Hotel> getHotelById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Hotel.fromMap(doc.data, doc.documentID);
  }

  Future removeHotel(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateHotel(Hotel data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addHotel(Hotel data) async {
    var result = await _api.addDocument(data.toJson());

    return;
  }
}
