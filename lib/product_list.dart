import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_sqflite_provider/cart_model.dart';
import 'package:shopping_cart_sqflite_provider/cart_provider.dart';
import 'package:shopping_cart_sqflite_provider/cart_screen.dart';
import 'package:shopping_cart_sqflite_provider/constants.dart';
import 'package:shopping_cart_sqflite_provider/db_helper.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    DbHelper? dbHelper = DbHelper();
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "Product List",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, value, child) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
                child: Badge(
                  label: Text(
                    value.getCounter().toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              );
            },
          ),

          SizedBox(width: 20),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: productName.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image(
                                width: 100,
                                height: 100,
                                image: NetworkImage(
                                  productImage[index].toString(),
                                ),
                              ),
                              SizedBox(width: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productName[index],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${productUnit[index]} \$${productPrice[index]}',
                                  ),
                                ],
                              ),
                              Spacer(),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: Colors.limeAccent.shade400,
                                ),
                                onPressed: () {
                                  dbHelper
                                      .insertItem(
                                        Cart(
                                          id: index,
                                          productId: index.toString(),
                                          productName:
                                              productName[index].toString(),
                                          initialPrice: productPrice[index],
                                          productPrice: productPrice[index],
                                          quantity: 1,
                                          unitTag:
                                              productUnit[index].toString(),
                                          image: productImage[index].toString(),
                                        ),
                                      )
                                      .then((value) {
                                        print("ADDED");
                                        cart.addTotalPrice(
                                          double.parse(
                                            productPrice[index].toString(),
                                          ),
                                        );
                                        cart.addCounter();
                                      });
                                },
                                child: Text(
                                  "Add to cart",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
