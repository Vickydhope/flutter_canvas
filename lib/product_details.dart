import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsScreen extends StatefulWidget {
  String pid;

  ProductDetailsScreen({Key? key, required this.pid}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              context.go(Uri(
                      path:
                          '/home/products/123/productDetail/${int.parse(widget.pid) + 1}')
                  .toString());
            },
            child: Text("Product Details ${widget.pid}")),
      ),
    );
  }
}
