import 'package:flutter/material.dart';

class Product {
  int id;
  String name;
  String price;
  String imageUrl;
  Product({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.imageUrl,
  });
}
