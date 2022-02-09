import 'dart:ffi';

import 'package:flutter/material.dart';

class ProductsModel {
  var id;
  String name = '';
  String image =
      'https://cdn4.iconfinder.com/data/icons/basic-ui-set-2-1/64/Basic_ui_2-16-512.png';
  int price = 0;
  int maxQuantity = 0;
  int quantity = 1;

  ProductsModel(String id, String name, String image, int price, int quantity) {
    this.id = id;
    this.name = name;
    this.image = image;
    this.price = price;
    this.maxQuantity = quantity;
  }
}
