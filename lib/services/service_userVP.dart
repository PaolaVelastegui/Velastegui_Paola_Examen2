import 'package:app_sistema_ventas/models/user_modelVP.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_sistema_ventas/models/user_modelVP.dart';
import 'dart:async';
import 'dart:convert';



class UserService{
  FirebaseFirestore? database;
   initialiase() {
    database = FirebaseFirestore.instance;
  }

  Future<List> getUserVP(String userName) async {
    List docs = [];
    QuerySnapshot querySnapshot;
    try {
      querySnapshot = await database!.collection('Usuarios').get();
      print('llega');
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          UserModel? user;
          if (userName == doc['usuario']) {
            user = UserModel(
                doc.id, doc['usuario'], doc['password'], doc['cedula']);
            docs.add(user);
          }
          print(doc['usuario']);
        }
      }
      //print(prods);
    } catch (e) {
      print("Lo siento :C");
    }
    return docs;
}

}