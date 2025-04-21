import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_sqflite_provider/cart_model.dart';
import 'package:shopping_cart_sqflite_provider/cart_provider.dart';
import 'package:shopping_cart_sqflite_provider/db_helper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DbHelper? dbHelper = DbHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "My Cart Items",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: cart.getData(),
              builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                if (snapshot.data!.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Image.asset("assets/emptyCart.png")),
                    ],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data![index].productName
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                dbHelper!.deleteItem(
                                                  snapshot.data![index].id!,
                                                );
                                                cart.removeCounter();
                                                cart.removeTotalPrice(
                                                  double.parse(
                                                    snapshot
                                                        .data![index]
                                                        .productPrice
                                                        .toString(),
                                                  ),
                                                );
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${snapshot.data![index].unitTag.toString()} \$${snapshot.data![index].productPrice.toString()}',
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.limeAccent.shade400,
                                        borderRadius: BorderRadius.circular(8),
                                      ),

                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              int quantity =
                                                  snapshot
                                                      .data![index]
                                                      .quantity!;
                                              int price =
                                                  snapshot
                                                      .data![index]
                                                      .initialPrice!;
                                              quantity--;
                                              int? newPrice = price * quantity;
                                              if (quantity > 0) {
                                                dbHelper!
                                                    .updateQuantity(
                                                      Cart(
                                                        id:
                                                            snapshot
                                                                .data![index]
                                                                .id,
                                                        productId:
                                                            snapshot
                                                                .data![index]
                                                                .id
                                                                .toString(),
                                                        productName:
                                                            snapshot
                                                                .data![index]
                                                                .productName,
                                                        initialPrice:
                                                            snapshot
                                                                .data![index]
                                                                .initialPrice,
                                                        productPrice: newPrice,
                                                        quantity: quantity,
                                                        unitTag:
                                                            snapshot
                                                                .data![index]
                                                                .unitTag
                                                                .toString(),
                                                        image:
                                                            snapshot
                                                                .data![index]
                                                                .image
                                                                .toString(),
                                                      ),
                                                    )
                                                    .then((value) {
                                                      newPrice = 0;
                                                      quantity = 0;
                                                      cart.removeTotalPrice(
                                                        double.parse(
                                                          snapshot
                                                              .data![index]
                                                              .initialPrice
                                                              .toString(),
                                                        ),
                                                      );
                                                    });
                                              }
                                            },
                                            icon: Icon(Icons.remove),
                                          ),
                                          Text(
                                            snapshot.data![index].quantity
                                                .toString(),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              int quantity =
                                                  snapshot
                                                      .data![index]
                                                      .quantity!;
                                              int price =
                                                  snapshot
                                                      .data![index]
                                                      .initialPrice!;
                                              quantity++;
                                              int? newPrice = price * quantity;
                                              dbHelper!
                                                  .updateQuantity(
                                                    Cart(
                                                      id:
                                                          snapshot
                                                              .data![index]
                                                              .id,
                                                      productId:
                                                          snapshot
                                                              .data![index]
                                                              .id
                                                              .toString(),
                                                      productName:
                                                          snapshot
                                                              .data![index]
                                                              .productName,
                                                      initialPrice:
                                                          snapshot
                                                              .data![index]
                                                              .initialPrice,
                                                      productPrice: newPrice,
                                                      quantity: quantity,
                                                      unitTag:
                                                          snapshot
                                                              .data![index]
                                                              .unitTag
                                                              .toString(),
                                                      image:
                                                          snapshot
                                                              .data![index]
                                                              .image
                                                              .toString(),
                                                    ),
                                                  )
                                                  .then((value) {
                                                    newPrice = 0;
                                                    quantity = 0;
                                                    cart.addTotalPrice(
                                                      double.parse(
                                                        snapshot
                                                            .data![index]
                                                            .initialPrice
                                                            .toString(),
                                                      ),
                                                    );
                                                  });
                                            },
                                            icon: Icon(Icons.add),
                                          ),
                                        ],
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
              },
            ),
          ),
          Consumer<CartProvider>(
            builder: (context, value, child) {
              return Visibility(
                visible:
                    value.getTotalPrice().toStringAsFixed(2) == "0.00"
                        ? false
                        : true,

                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),

                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Grand Total:",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              r"$" + value.getTotalPrice().toStringAsFixed(2),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
