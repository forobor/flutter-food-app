import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get favoriteProducts {
    return List.from(
        _products.where((Product product) => product.isFavorite).toList());
  }

  Product getProduct(int index) {
    return index != null ? Product.from(_products[index]) : null;
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(Product product, int index) {
    _products[index] = product;
    notifyListeners();
  }

  void deleteProduct(int index) {
    _products.removeAt(index);
    notifyListeners();
  }

  void toggleProductFavorite(int index) {
    // Product product = new Product(
    //     title: _products[index].title,
    //     price: _products[index].price,
    //     description: _products[index].description,
    //     image: _products[index].image,
    //     isFavorite: !_products[index].isFavorite);

    Product product =
        new Product.from(_products[index], !_products[index].isFavorite);
    updateProduct(product, index);
    notifyListeners();
  }
}
