import 'package:flutter/cupertino.dart';

class Product {
  String id;
  String name;
  String price;
  String location;
  String category;
  String description;
  int quantity;
  Product(
      {
        this.quantity,
        @required this.id,
       @required this.price,
      @required this.description,
      @required this.category,
      @required this.location,
      @required this.name});
}
