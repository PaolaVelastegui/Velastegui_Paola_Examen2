

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class UserService{
FirebaseFirestore? database;
initialiase (){
  database = FirebaseFirestore.instance;

}

Future<List>getUserVP() async{
  List docs = [];
  QuerySnapshot querySnapshot;


  try{

  }
}

}