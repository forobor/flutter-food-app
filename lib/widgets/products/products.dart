import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_card.dart';
import '../../models/product.dart';
import '../../scoped-models/products.dart';
import '../../scoped-models/app_model.dart';

class Products extends StatelessWidget {
  Widget _buildProductItem(BuildContext context, int index) {
    return ProductCard(index);
  }

  @override
  Widget build(BuildContext context) {
    bool isShowFavorite =
        ScopedModel.of<AppModel>(context, rebuildOnChange: true).showFavorite;
    ProductsModel productModel =
        ScopedModel.of<ProductsModel>(context, rebuildOnChange: true);
    List<Product> products =
        isShowFavorite ? productModel.favoriteProducts : productModel.products;
    return products.length > 0
        ? ListView.builder(
            itemBuilder: _buildProductItem,
            itemCount: products.length,
          )
        : Center(child: Text('No products. Add product'));
  }
}
