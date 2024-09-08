import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductServices {
  Future<List<Product>> getProducts() async {
    List<Product> products = [];
    var url = Uri.parse("https://dummyjson.com/products");

    try {
      // Make the HTTP GET request
      var res = await http.get(url);

      // Check if the response status code is 200 OK
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        // Ensure 'products' key is present in the response
        if (data.containsKey('products')) {
          for (var item in data['products']) {
            var pro = Product.fromJson(item);
            products.add(pro);
          }
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        throw Exception("Failed to load products, status code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error fetching products: $e");
      // Handle the error or rethrow
    }

    return products;
  }

  Future<Product> getProductById(num id) async {
    var url = Uri.parse("https://dummyjson.com/products/$id");

    try {
      var res = await http.get(url);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        return Product.fromJson(data);
      } else {
        throw Exception("Failed to load product, status code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error fetching product by id: $e");
      throw e; // Rethrow the error
    }
  }

  Future<bool> addProduct(Product newProduct) async {
    var url = Uri.parse("https://dummyjson.com/products/add");
    var data = newProduct.toJson();
    var encodedData = jsonEncode(data);

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: encodedData,
      );

      if (response.statusCode == 201) {
        return true; // Product successfully added
      } else {
        throw Exception("Failed to add product, status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error adding product: $e");
      return false; // Indicate failure
    }
  }
}
