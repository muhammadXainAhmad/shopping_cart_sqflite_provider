import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_sqflite_provider/cart_model.dart';
import 'package:shopping_cart_sqflite_provider/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Cart List", style: TextStyle(color: Colors.white)),
        actions: [
          Consumer<CartProvider>(
            builder: (context, value, child) {
              return Badge(
                label: Text(
                  value.getCounter().toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              );
            },
          ),

          SizedBox(width: 20),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: cart.getData(),
            builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
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
                                      snapshot.data![index].image.toString(),
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].productName
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data![index].unitTag.toString()} \$${snapshot.data![index].productPrice.toString()}',
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor:
                                          Colors.limeAccent.shade400,
                                    ),
                                    onPressed: () {},
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
                );
              }
              return Text("");
            },
          ),
        ],
      ),
    );
  }
}
