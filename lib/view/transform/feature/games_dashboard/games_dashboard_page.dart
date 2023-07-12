import 'package:flutter/material.dart';

class GamesDashboardPage extends StatefulWidget {
  const GamesDashboardPage({Key? key}) : super(key: key);

  @override
  State<GamesDashboardPage> createState() => _GamesDashboardPageState();
}

class _GamesDashboardPageState extends State<GamesDashboardPage> {
  late final ScrollController controller;

  int topIndex = 0;

  @override
  void initState() {
    const averageHeight = (50 * 99 + 150) / 100;

    print(averageHeight * 100);
    controller = ScrollController()
      ..addListener(() {
        setState(() {
          final currentPoss = controller.offset;
          topIndex = currentPoss ~/ averageHeight;

          print("Top Index : $topIndex");
          print("Offset : ${controller.offset}");
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: const ClampingScrollPhysics(),
        controller: controller,
        itemBuilder: (context, index) => AnimatedContainer(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: index == topIndex ? Colors.green : Colors.blue,
              borderRadius: BorderRadius.circular(16)),
          height: index == topIndex ? 150 : 50,
          duration: const Duration(milliseconds: 300),
          child: Center(
            child: Text(
              "Item $index",
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
        ),
        itemCount: 100,
      ),
    );
  }
}
