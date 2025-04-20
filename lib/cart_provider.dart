import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cart_sqflite_provider/cart_model.dart';
import 'package:shopping_cart_sqflite_provider/db_helper.dart';

class CartProvider extends ChangeNotifier {
  DbHelper db = DbHelper();
  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;

  Future<List<Cart>> getData() async {
    _cart = db.getCartList();
    return _cart;
  }

  void _setPrefItem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("cart_items", _counter);
    prefs.setDouble("total_price", totalPrice);
    notifyListeners();
  }

  void _gettPrefItem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt("cart_items") ?? 0;
    _totalPrice = prefs.getDouble("total_price") ?? 0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    _setPrefItem();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    _setPrefItem();
    notifyListeners();
  }

  int getCounter() {
    _gettPrefItem();
    return _counter;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefItem();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefItem();
    notifyListeners();
  }

  double getTotalPrice() {
    _gettPrefItem();
    return _totalPrice;
  }
}
