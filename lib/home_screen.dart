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
        child: ListView(
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
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoutes.neomorphism.name);
              },
              child: Text(AppRoutes.neomorphism.name.toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoutes.glassmorphism.name);
              },
              child: Text(AppRoutes.glassmorphism.name.toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoutes.movies.name);
              },
              child: Text(AppRoutes.movies.name.toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoutes.heroList.name);
              },
              child: Text(AppRoutes.heroList.name.toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoutes.movieGrid.name);
              },
              child: Text(AppRoutes.movieGrid.name.toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoutes.places.name);
              },
              child: Text(AppRoutes.places.name.toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoutes.diskAnimation.name);
              },
              child: Text(AppRoutes.diskAnimation.name.toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoutes.gamesDashboard.name);
              },
              child: Text(AppRoutes.gamesDashboard.name.toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoutes.clock.name);
              },
              child: Text(AppRoutes.clock.name.toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoutes.draggableBottomSheet.name);
              },
              child: Text(AppRoutes.draggableBottomSheet.name.toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoutes.customClipper.name);
              },
              child: Text(AppRoutes.customClipper.name.toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoutes.animatedSidebar.name);
              },
              child: Text(AppRoutes.animatedSidebar.name.toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoutes.blackhole.name);
              },
              child: Text(AppRoutes.blackhole.name.toUpperCase()),
            ),
            TextButton(
              onPressed: () {
                context.pushNamed(AppRoutes.customSliverAppBar.name);
              },
              child: Text(AppRoutes.customSliverAppBar.name.toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}
