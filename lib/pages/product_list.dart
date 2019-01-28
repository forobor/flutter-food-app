import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './product_edit.dart';
import '../models/product.dart';
import '../scoped-models/products.dart';

class ProductListPage extends StatelessWidget {
  void _navigateToProductEdit(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ProductEditPage(index);
        },
      ),
    );
  }

  void _deleteProduct(
      DismissDirection direction, int index, Function deleteProduct) {
    if (direction == DismissDirection.endToStart) {
      deleteProduct(index);
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    ProductsModel productModel =
        ScopedModel.of<ProductsModel>(context, rebuildOnChange: true);
    Product product = productModel.products[index];
    Function deleteProduct = productModel.deleteProduct;
    // swipe out
    return Dismissible(
      key: Key(product.title),
      onDismissed: (DismissDirection direction) {
        _deleteProduct(direction, index, deleteProduct);
      },
      background: Container(color: Colors.red),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                product.image,
              ),
            ),
            title: Text(product.title),
            subtitle: Text('\$${product.price.toString()}'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _navigateToProductEdit(context, index);
              },
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products =
        ScopedModel.of<ProductsModel>(context, rebuildOnChange: true).products;
    return ListView.builder(
      itemBuilder: _buildListItem,
      itemCount: products.length,
    );
  }
}
