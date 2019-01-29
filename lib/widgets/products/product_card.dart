import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './price_tag.dart';
import '../ui_elements/title_default.dart';
import './address_tag.dart';
import '../../models/product.dart';
import '../../scoped-models/products.dart';

class ProductCard extends StatelessWidget {
  final int index;

  ProductCard(this.index);

  Icon _displayFavorite(bool isFavorite) {
    if (isFavorite) {
      return Icon(Icons.favorite_border);
    }
    return Icon(Icons.favorite);
  }

  @override
  Widget build(BuildContext context) {
    ProductsModel productModel =
        ScopedModel.of<ProductsModel>(context, rebuildOnChange: true);
    final Product product = productModel.getProduct(index);
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
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Colors.red,
                onPressed: () => productModel.toggleProductFavorite(index),
              ),
            ],
          )
        ],
      ),
    );
  }
}
