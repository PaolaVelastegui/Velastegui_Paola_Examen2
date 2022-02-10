

import 'package:app_sistema_ventas/models/user_modelVP.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_sistema_ventas/models/user_modelVP.dart';

class UserService{
FirebaseFirestore? database;
initialiase (){
  database = FirebaseFirestore.instance;

}

Future<List>getUserVP() async{
  List docs = [];
  QuerySnapshot querySnapshot;


  try{
    querySnapshot = await database!.collection('Usuarios').get();
    if(querySnapshot.docs.isNotEmpty){
      for(var doc in querySnapshot.docs){
        UserModel? user;
        user = UserModel(doc.id,doc['usuario'],doc['password'],doc['cedula']);
        docs.add(user);
      }
    }
  }catch (e){
    print('no es posible');
  }
  return docs;
}

}