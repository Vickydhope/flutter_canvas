import 'package:flutter/material.dart';
import 'package:flutter_canvas/main.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoutes.cards.name);
              },
              child: const Text("Swipe Credit Card"),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoutes.cards3dHome.name);
              },
              child: const Text("3D Card Animation"),
            ),
          ],
        ),
      ),
    );
  }
}
