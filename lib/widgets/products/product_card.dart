import 'package:flutter/material.dart';

import './price_tag.dart';
import '../ui_elements/title_default.dart';
import './address_tag.dart';
import '../../models/product.dart';



class ProductCard extends StatelessWidget {
  final Product product;
  final int index;

  ProductCard(this.product, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product.image),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TitleDefault(product.title),
                  SizedBox(width: 9.0),
                  PriceTag(product.price),
                ],
              ),
            ),
          ),
          AddressTag('Tallinn'),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.info),
                color: Theme.of(context).accentColor,
                // for navigation
                onPressed: () => Navigator.pushNamed<bool>(
                            context, '/product/' + index.toString())
                        //get data from screen, from where it popped
                        .then((bool value) {
                      if (value) {
                        // deleteProduct(index);
                      }
                    }),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
