import 'package:flutter/material.dart';

import '../widgets/helpers/ensure-visible.dart';
import '../models/product.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Product product;
  final int productIndex;

  ProductEditPage(
      {this.addProduct, this.updateProduct, this.product, this.productIndex});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPage();
  }
}

class _ProductEditPage extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'price': null,
    'description': null,
    'image': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    final Product product = Product(
      title: _formData['title'],
      price: _formData['price'],
      description: _formData['description'],
      image: _formData['image'],
    );
    if (widget.product == null) {
      widget.addProduct(product);
    } else {
      widget.updateProduct(widget.productIndex, product);
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double listPadding =
        MediaQuery.of(context).orientation == Orientation.landscape
            ? 60.0
            : 0.0;

    final Widget _main = GestureDetector(
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
              EnsureVisibleWhenFocused(
                focusNode: _titleFocusNode,
                child: TextFormField(
                  focusNode: _titleFocusNode,
                  decoration: InputDecoration(labelText: 'Product Title'),
                  initialValue:
                      widget.product != null ? widget.product.title : '',
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Title is requiered.';
                    }
                  },
                  onSaved: (String value) {
                    _formData['title'] = value;
                  },
                ),
              ),
              EnsureVisibleWhenFocused(
                focusNode: _priceFocusNode,
                child: TextFormField(
                  focusNode: _priceFocusNode,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Price'),
                  initialValue: widget.product != null
                      ? widget.product.price.toString()
                      : '',
                  validator: (String value) {
                    if (value.isEmpty ||
                        !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$')
                            .hasMatch(value)) {
                      return 'Price is requiered and should be a number.';
                    }
                  },
                  onSaved: (String value) {
                    _formData['price'] = double.parse(value);
                  },
                ),
              ),
              EnsureVisibleWhenFocused(
                focusNode: _descriptionFocusNode,
                child: TextFormField(
                  focusNode: _descriptionFocusNode,
                  decoration: InputDecoration(labelText: 'Description'),
                  initialValue:
                      widget.product != null ? widget.product.description : '',
                  maxLines: 4,
                  onSaved: (String value) {
                    _formData['description'] = value;
                  },
                ),
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
    return widget.product == null
        ? _main
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Prodcut'),
            ),
            body: _main);
  }
}
