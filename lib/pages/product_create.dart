import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePage();
  }
}

class _ProductCreatePage extends State<ProductCreatePage> {
  String _title;
  double _price;
  String _description;

  @override
  Widget build(BuildContext context) {
    final double listPadding =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? 60.0
            : 0.0;
    return Container(
      padding: EdgeInsets.all(10.0),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: listPadding),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Product Title'),
            onChanged: (String value) {
              setState(() {
                _title = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
            onChanged: (String value) {
              setState(() {
                _price = double.parse(value);
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Description'),
            onChanged: (String value) {
              setState(() {
                _description = value;
              });
            },
            maxLines: 4,
          ),
          SwitchListTile(
            value: true,
            onChanged: (bool value) {},
            title: Text('Accept'),
          ),
          SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text('Save'),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              onPressed: () {
                final Map<String, dynamic> product = {
                  'title': _title,
                  'price': _price,
                  'description': _description,
                  'imageUrl': 'assets/food.jpg'
                };
                widget.addProduct(product);
                Navigator.pushReplacementNamed(context, '/products');
              },
            ),
          ),
        ],
      ),
    );
  }
}
