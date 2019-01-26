import 'package:flutter/material.dart';

import './product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;

  ProductListPage(this.products, this.updateProduct);

  Widget _buildListItem(BuildContext context, int index) {
    return ListTile(
      leading: Image.asset(
        products[index]['imageUrl'],
        height: 50.0,
        width: 50.0,
      ),
      title: Text(products[index]['title']),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProductEditPage(product: products[index], updateProduct: updateProduct, productIndex: index,);
              },
            ),
          );
        },
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
