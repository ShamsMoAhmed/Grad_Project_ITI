import 'package:graduation_project/models/product_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Product> products = [];

  addItem(Product prod) {
    products.add(prod);
    notifyListeners();
  }

  removeItem(Product prod) {
    products.remove(prod);
    notifyListeners();
  }

  clearItems() {
    products = [];
    notifyListeners();
  }

  bool isProductExist(Product prod) {
    bool exist = false;
    for (var item in products) {
      if (prod.id == item.id) {
        exist = true;
      }
    }
    return exist;
  }
  
}
