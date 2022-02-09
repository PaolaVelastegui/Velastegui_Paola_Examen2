import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_sistema_ventas/models/products_model.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

class ProductService {
  FirebaseFirestore? database;
  initialiase() {
    database = FirebaseFirestore.instance;
  }

  Future<List> getProductList() async {
    List docs = [];
    QuerySnapshot querySnapshot;
    /*
    database!.child('productos').get().then(
        (resultado) => {print(jsonDecode(resultado.value.toString()).nombre)});
    */

    //var jsontext = jsonDecode(json);
    //print(jsontext[1].nombre);

    try {
      querySnapshot = await database!.collection('Productos').get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          ProductsModel? product;
          if (doc['image'] == '') {
            product = ProductsModel(
                doc.id,
                doc['name'],
                'https://cdn4.iconfinder.com/data/icons/basic-ui-set-2-1/64/Basic_ui_2-16-512.png',
                doc['price'],
                doc['quantity']);
          } else {
            product = ProductsModel(doc.id, doc['name'], doc['image'],
                doc['price'], doc['quantity']);
          }
          docs.add(product);
        }
      }
      //print(prods);
    } catch (e) {
      print("Lo siento :C");
    }
    return docs;
  }
}
