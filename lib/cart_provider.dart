import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  void _setPrefItem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("cart_items", _counter);
    prefs.setDouble("total_price", totalPrice);
    notifyListeners();
  }

  void _gettPrefItem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt("cart_item") ?? 0;
    _totalPrice = prefs.getDouble("total_price") ?? 0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    _setPrefItem();
    notifyListeners();
  }

  void removeCounter() {
    _counter++;
    _setPrefItem();
    notifyListeners();
  }

  int getCounter() {
    _gettPrefItem();
    return _counter;
  }
}
