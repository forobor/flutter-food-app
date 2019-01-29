import 'package:flutter/material.dart';

class Product {
  final String title;
  final double price;
  final String description;
  final String image;
  final bool isFavorite;

  Product(
      {@required this.title,
      @required this.price,
      @required this.description,
      @required this.image,
      this.isFavorite = false});

  Product.from(Product obj, [bool isFavorite])
      : this(
            title: obj.title,
            price: obj.price,
            description: obj.description,
            image: obj.image,
            isFavorite: isFavorite ?? obj.isFavorite);
}
