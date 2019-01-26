import 'package:flutter/material.dart';

import './product_card.dart';
import '../../models/product.dart';

class Products extends StatelessWidget {
  // final - constant
  final List<Product> products;

  // constructor. argument is brackets is optional, f.e. [this.products]
  Products(this.products);

  Widget _buildProductItem(BuildContext context, int index) {
    return ProductCard(products[index], index);
  }

  @override
  Widget build(BuildContext context) {
    return products.length > 0
        ? ListView.builder(
            itemBuilder: _buildProductItem,
            itemCount: products.length,
          )
        : Center(child: Text('No products. Add product'));
  }
}
