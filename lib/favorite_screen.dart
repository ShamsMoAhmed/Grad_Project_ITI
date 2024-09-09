import 'package:flutter/material.dart';
import 'package:graduation_project/product_details.dart';
import 'package:provider/provider.dart';
import 'package:graduation_project/favorite_provider.dart';
import 'package:graduation_project/product_screen.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
         leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => ProductScreen()),
            );
          },
        ),
      ),
      body: favoriteProvider.favorites.isEmpty
          ? const Center(child: Text("No favorites yet!"))
          : ListView.builder(
              itemCount: favoriteProvider.favorites.length,
              itemBuilder: (context, index) {
                final product = favoriteProvider.favorites[index];
                return ListTile(
                  leading: SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.network(product.imageUrl)),
                  title: Text(product.productTitle),
                  subtitle: Text("\$${product.price}"),
                  
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Optionally, you can add functionality to remove an item from favorites
                      favoriteProvider.removeFavorite(product);
                    },
                  ),
                  onTap: () {
                    // Optionally, you can navigate to the product details screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetails(productId: product.id),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
