import 'package:flutter/material.dart';

import './product_edit.dart';
import '../models/product.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  void _navigateToProductEdit(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ProductEditPage(
            product: products[index],
            updateProduct: updateProduct,
            productIndex: index,
          );
        },
      ),
    );
  }

  void _deleteProduct(DismissDirection direction, int index) {
    if (direction == DismissDirection.endToStart) {
      deleteProduct(index);
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    // swipe out
    return Dismissible(
      key: Key(products[index].title),
      onDismissed: (DismissDirection direction) {
        _deleteProduct(direction, index);
      },
      background: Container(color: Colors.red),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                products[index].image,
              ),
            ),
            title: Text(products[index].title),
            subtitle: Text('\$${products[index].price.toString()}'),
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
    return ListView.builder(
      itemBuilder: _buildListItem,
      itemCount: products.length,
    );
  }
}
