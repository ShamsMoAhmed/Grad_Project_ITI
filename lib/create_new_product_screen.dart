// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:graduation_project/services/product_service.dart';
import 'package:flutter/material.dart';

import 'models/product_model.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({Key? key}) : super(key: key);

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var descController = TextEditingController();
  var brandController = TextEditingController();

  String? brand;
  String? color;
  bool isFree = false;

  bool isLoading = false;
  //To control the form and can modify on it:    this is like controller.
  var formKey = GlobalKey<FormState>();
  final productService = ProductServices();

  addProducts() async {
    setState(() {
      isLoading = true;
    });
    var isValid = formKey.currentState!.validate();
    if (isValid == false) return;

    var prod = Product(
      id: 0,
      productTitle: titleController.text,
      price: num.parse(priceController.text),
      description: descController.text,
      stock: 300,
      brand: brandController.text,
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuJjyo2eGSU4n_wuaLhHWjM5CUjw9ZUvhA9DgaqxnO&s",
    );

    try {
      var isAdded = await productService.addProduct(prod);
      if (isAdded) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Product is added"),
          ),
        );
        titleController.clear();
        priceController.clear();
        descController.clear();
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error"),
          ),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Product can't be added"),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descController.dispose();
    brandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a Product"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (isLoading)
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: ((value) {
                        if (value == null) {
                          return "Please write title";
                        } else if (value.trim().isEmpty) {
                          return "title can not be empty";
                        } else {
                          return null;
                        }
                      }),
                      controller: titleController,
                      decoration: InputDecoration(
                        label: Text(
                          "title",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null) {
                          return "Please write the price";
                        } else if (value.trim().isEmpty) {
                          return "Price can not be empty";
                        }
                        num price = num.parse(value);
                        if (price <= 0) {
                          return "Price must be more than 1";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: priceController,
                      decoration: InputDecoration(
                        label: Text(
                          "price",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null) {
                          return "Please write the description";
                        } else if (value.trim().isEmpty) {
                          return "Desc can not be empty";
                        } else if (value.trim().length <= 10) {
                          return "this desc is too short";
                        } else {
                          return null;
                        }
                      },
                      controller: descController,
                      decoration: InputDecoration(
                        label: Text(
                          "description",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      
                        validator: (value) {
                          if (value == null) {
                            return "Please choose a brand.";
                          } else {
                            return null;
                          }
                        },
                        hint: Text("Select a brand"),
                        value: brand,
                        // ignore: prefer_const_literals_to_create_immutables
                        items: [
                          DropdownMenuItem(
                            
                            child: Text("Apple"),
                            value: "apple",
                          ),
                          DropdownMenuItem<String>(
                            child: Text("Huawei"),
                            value: "huawei",
                          ),
                          DropdownMenuItem<String>(
                            child: Text("Nokia"),
                            value: "nokia",
                          ),
                          DropdownMenuItem<String>(
                            child: Text("Samsung"),
                            value: "samsung",
                          )
                        ],
                        onChanged: (val) {
                          setState(() {
                            brand = val;
                          });
                        }),
                    Row(
                      children: [
                        Radio<String?>(
                            value: "white",
                            groupValue: color,
                            onChanged: (value) {
                              setState(() {
                                color = value;
                              });
                            }),
                        Text("White"),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String?>(
                            value: "black",
                            groupValue: color,
                            onChanged: (value) {
                              setState(() {
                                color = value;
                              });
                            }),
                        Text("Black"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: isFree,
                            onChanged: (val) {
                              setState(() {
                                isFree = val!;
                              });
                            }),
                        Text("Price is free")
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addProducts();
                      },
                      child: Text(
                        "add product",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
