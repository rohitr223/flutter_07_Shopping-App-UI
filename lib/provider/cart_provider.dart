import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  // all selected products go here
  final List<Map<String, dynamic>> cart = [];

  void addProduct(Map<String, dynamic> product) {
    cart.add(product);
    notifyListeners(); // to update the data
  }

  void removeProduct(Map<String, dynamic> product) {
    cart.remove(product);
    notifyListeners(); // to update the data
  }
}
