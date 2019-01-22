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
  final Map<String, dynamic> _formData = {
    'title': null,
    'price': null,
    'description': null,
    'imageUrl': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    widget.addProduct(_formData);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double listPadding =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? 60.0
            : 0.0;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: listPadding),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Title'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Title is requiered.';
                  }
                },
                onSaved: (String value) {
                  _formData['title'] = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (String value) {
                  if (value.isEmpty ||
                      !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
                    return 'Price is requiered and should be a number.';
                  }
                },
                onSaved: (String value) {
                  _formData['price'] = double.parse(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 4,
                onSaved: (String value) {
                  _formData['description'] = value;
                },
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
                  onPressed: _submitForm,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
