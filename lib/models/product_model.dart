class Product {
  final String imageUrl;
  final String productTitle;
  final num price;
  final int id;
  final String description;
  final String brand;
  final num stock;

  //constructor
  Product({
    required this.imageUrl,
    required this.price,
    required this.productTitle,
    required this.id,
    required this.description,
    required this.brand,
    required this.stock,
  });
  // static & factory both of them enable us to get the object in class without calling this object before.
  //factory must use . unlike static
  // factory enforce me to return new object from its class
  // faster in compile
  factory Product.fromJson(Map data) {
    // ignore: unnecessary_new
    return new Product(
      imageUrl: data["thumbnail"],
      price: data["price"],
      productTitle: data["title"],
      id: data["id"],
      description: data["description"],
      brand: data["brand"],
      stock: data["stock"],
    );
  }

  Map toJson() {
    return {
      "title": productTitle,
      "price": price,
      "description": description,
      "category": "smartphones",
      "stock": stock,
      "brand": brand,
      "thumbnail": imageUrl,
    };
  }
}
