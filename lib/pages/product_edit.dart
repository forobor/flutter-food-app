import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/helpers/ensure-visible.dart';
import '../models/product.dart';
import '../scoped-models/products.dart';

class ProductEditPage extends StatefulWidget {
  final int productIndex;

  ProductEditPage([this.productIndex]);

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPage();
  }
}

class _ProductEditPage extends State<ProductEditPage> {
  ProductsModel productModel;
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
    Function addProduct = productModel.addProduct;
    Function updateProduct = productModel.updateProduct;

    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final Product product = Product(
      title: _formData['title'],
      price: _formData['price'],
      description: _formData['description'],
      image: _formData['image'],
    );
    if (widget.productIndex == null) {
      addProduct(product);
    } else {
      updateProduct(product, widget.productIndex);
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _mainBuild() {
    final Product product = productModel.getProduct(widget.productIndex);
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
              EnsureVisibleWhenFocused(
                focusNode: _titleFocusNode,
                child: TextFormField(
                  focusNode: _titleFocusNode,
                  decoration: InputDecoration(labelText: 'Product Title'),
                  initialValue: product != null ? product.title : '',
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
                  initialValue: product != null ? product.price.toString() : '',
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
                  initialValue: product != null ? product.description : '',
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
  }

  @override
  Widget build(BuildContext context) {
    productModel =
        ScopedModel.of<ProductsModel>(context, rebuildOnChange: true);
    return widget.productIndex == null
        ? _mainBuild()
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Prodcut'),
            ),
            body: _mainBuild());
  }
}
