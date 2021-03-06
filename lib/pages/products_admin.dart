import 'package:flutter/material.dart';

import './product_edit.dart';
import './product_list.dart';
import '../models/product.dart';

class ProductsAdminPage extends StatelessWidget {
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('All Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/products');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildDrawer(context),
        appBar: AppBar(
          title: Text('Product Manager'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.create), text: 'Create Product'),
              Tab(icon: Icon(Icons.list), text: 'My Products')
            ],
          ),
        ),
        // navigation tabs. no need Scaffold in this page
        body: TabBarView(
          children: <Widget>[
            ProductEditPage(),
            ProductListPage()
          ],
        ),
      ),
    );
  }
}
