import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hoteles/core/models/userModel.dart';
import 'package:hoteles/core/services/ApiUser.dart';
import 'package:hoteles/locator.dart';

class CRUDUser extends ChangeNotifier {
  ApiUser _api = locator<ApiUser>();

  List<User> usuarios;

  Future<List<User>> fetchUsuarios() async {
    var result = await _api.getDataCollection();
    usuarios = result.documents
        .map((doc) => User.fromMap(doc.data, doc.documentID))
        .toList();
    return usuarios;
  }

  Stream<QuerySnapshot> fetchUsuariosAsStream() {
    return _api.streamDataCollection();
  }

  Future<User> getUserById(String id) async {
    var doc = await _api.getDocumentById(id);
    return User.fromMap(doc.data, doc.documentID);
  }

  Future removeUser(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateUser(User data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addUser(User data) async {
    var result = await _api.addDocument(data.toJson());

    return;
  }

  Stream<QuerySnapshot> filtroUser(String filtro) {
    return _api.filtroNombre(filtro);
  }
}
