// ignore_for_file: prefer_const_constructors

import 'package:graduation_project/models/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Theme.dart';
import 'models/product_model.dart';
import 'services/product_service.dart';

class ProductDetails extends StatefulWidget {
  final int productId;
  const ProductDetails({Key? key, required this.productId}) : super(key: key);
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isLoading = true;
  Product? details;
  final productServices = ProductServices();
  getDetails() async {
    try {
      var prods = await productServices.getProductById(widget.productId);

      setState(() {
        isLoading = false;
        details = prods;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("this page can not load"),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
   
    var cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Product Details")),
      body: SafeArea(
          child: ListView(
        children: [
          if (isLoading == true)
            Row(
              children: const [
                CircularProgressIndicator(
                    strokeWidth: 6,

),
              ],
            ),
          if (details != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    Image.network(
                      details!.imageUrl,
                      height: 200,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "${details!.price} \$",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.red[400],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      details!.description,
                      style: TextStyle(fontSize: 17, color: Colors.blue[900]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      details!.productTitle,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (!cart.isProductExist(details!))
                      ElevatedButton(
                        onPressed: () {
                          if (cart.isProductExist(details!) == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("This product is already exist"),
                              ),
                            );
                          } else {
                            cart.addItem(details!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Product is added"),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Add to cart",
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    else
                      Text("Product is already in cart"),
                  ],
                ),
              ),
            ),
        ],
      )),
    );
  }
}
