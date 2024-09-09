import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/Theme.dart';
import 'package:graduation_project/cart_screen.dart';
import 'package:graduation_project/create_new_product_screen.dart';
import 'package:graduation_project/favorite_screen.dart';
import 'package:graduation_project/models/product_model.dart';
import 'package:graduation_project/product_details.dart';
import 'package:graduation_project/services/product_service.dart';
import 'package:graduation_project/favorite_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  // Fetch products from the service
  Future<void> get_Product() async {
    setState(() {
      isLoading = true;
      products = [];
    });
    try {
      var prod = await productService.getProducts();
      setState(() {
        products = prod;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("This page cannot load")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    get_Product();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

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
        child: const Icon(Icons.edit),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: (index) {
          setState(() {
            tabIndex = index;
          });
          if (tabIndex == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProductScreen()),
            );
          } else if (tabIndex == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) =>  FavoriteScreen()),
            );
          } else if (tabIndex == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text(
          "Products",
          style: TextStyle(fontSize: 25),
        ),
        actions: [
         IconButton(onPressed: () async {
        try {
          await FirebaseAuth.instance.signOut(); // Sign out the user
          Navigator.of(context).pushReplacementNamed('/login'); // Navigate to login screen
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error logging out. Please try again.")),
          );
        };},
             icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: get_Product,
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 500,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          final isFavorite = favoriteProvider.isFavorite(product);

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Column(
                                children: [
                                  Image.network(
                                    product.imageUrl,
                                    height: 200,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    "\$${product.price}",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.red[400],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    product.productTitle,
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ProductDetails(productId: product.id),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "More info",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: isFavorite ? Colors.red : Colors.grey,
                                    ),
                                    onPressed: () {
                                      favoriteProvider.toggleFavorite(product);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
