import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'models/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  for (var item in cart.products)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.network(item.imageUrl)),
                        title: Text(item.productTitle),
                        subtitle: Text(item.description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("${item.price}\$"),
                            IconButton(
                              onPressed: () {
                                cart.removeItem(item);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (cart.products.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  cart.clearItems();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Icon(Icons.delete),
                    Text("Clear Cart"),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
