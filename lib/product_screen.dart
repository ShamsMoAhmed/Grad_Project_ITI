// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:graduation_project/cart_screen.dart';
import 'package:graduation_project/create_new_product_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'models/product_model.dart';
import 'product_details.dart';
import 'services/product_service.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isLoading = true;

  List<Product> products = [];
  final productService = ProductServices();
  int tabIndex = 0;

  get_Product() async {
    if (products.isNotEmpty) {
      setState(() {
        products = [];
      });
    }
    try {
      var prod = await productService.getProducts();

      setState(() {
        isLoading = false;
        products = prod;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("This page can not load"),
        ));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Product();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreateProductScreen(),
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: (index) {
          setState(() {
            tabIndex = index;
          });
          if (tabIndex == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CartScreen(),
              ),
            );
          }
        },
        // ignore: prefer_const_literals_to_create_immutables, duplicate_ignore
        items: [
          // ignore: prefer_const_constructors
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_rounded), label: "Cart"),
        ],
      ),
      appBar: AppBar(
        title: Text(
          "Products",
          style: TextStyle(fontSize: 25),
        ),
        actions: [
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (isLoading)
              Row(
                children: const [
                  CircularProgressIndicator(),
                ],
              ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await get_Product();
                },
                //child: ListView.builder(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 500),
                  itemCount: products.length,
                  itemBuilder: ((context, index) {
                    final item = products[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          children: [
                            if (isLoading == true)
                              Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  CircularProgressIndicator(),
                                ],
                              ),
                            Image.network(
                              item.imageUrl,
                              height: 200,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "${item.price} \$",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.red[400],
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              item.productTitle,
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProductDetails(
                                      productId: item.id,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "More info",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
