import 'package:flutter/material.dart';
import 'models/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  void addFavorite(Product product) {
    _favorites.add(product);
    notifyListeners();
  }

  void removeFavorite(Product product) {
    _favorites.remove(product);
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favorites.contains(product);
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      removeFavorite(product);
    } else {
      addFavorite(product);
    }
  }
}
