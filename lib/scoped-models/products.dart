import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];

  List<Product> get products {
    return List.from(_products);
  }

  Product getProduct (int index) {
    return index != null ? _products[index] : null;
  }

  void addProduct(Product product) {
    _products.add(product);
  }

  void updateProduct(Product product, int index) {
    _products[index] = product;
  }

  void deleteProduct(int index) {
    _products.removeAt(index);
  }

}
