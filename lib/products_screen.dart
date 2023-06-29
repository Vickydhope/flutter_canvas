import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    print(GoRouter.of(context).location);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: Center(
        child: TextButton(
          child: const Text("Open Details"),
          onPressed: () {
            context.go("${GoRouter.of(context).location}/productDetail/123444".replaceAll("//", "/"));
          },
        ),
      ),
    );
  }
}
