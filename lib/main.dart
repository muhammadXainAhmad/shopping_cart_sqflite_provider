import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_sqflite_provider/cart_provider.dart';
import 'package:shopping_cart_sqflite_provider/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const ProductListPage(),
      ),
    );
  }
}
