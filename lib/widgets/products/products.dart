import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_card.dart';
import '../../models/product.dart';
import '../../scoped-models/products.dart';

class Products extends StatelessWidget {
  Widget _buildProductItem(BuildContext context, int index, ProductsModel model) {
    return ProductCard(model.products[index], index);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return model.products.length > 0
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) =>
                    _buildProductItem(context, index, model),
                itemCount: model.products.length,
              )
            : Center(child: Text('No products. Add product'));
      },
    );
  }
}
