import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/products.dart';
import '../scoped-models/app_model.dart';

class ProductsPage extends StatelessWidget {
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppModel appModel =
        ScopedModel.of<AppModel>(context, rebuildOnChange: true);
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Text('EasyList'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
                appModel.showFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              appModel.toggleFavorite();
            },
          )
        ],
      ),
      body: Products(),
    );
  }
}
