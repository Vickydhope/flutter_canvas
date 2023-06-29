import 'package:flutter/material.dart';


import '../../../../../generated/assets.dart';
import '../components/moving_card.widget.dart';

class MovingCardPage extends StatefulWidget {
  const MovingCardPage({Key? key}) : super(key: key);

  @override
  State<MovingCardPage> createState() => _MovingCardPageState();
}

class _MovingCardPageState extends State<MovingCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Credit Card"),
      ),
      body: const MovingCardWidget(
          urlBack: Assets.images1Back, urlFront: Assets.images1Front),
    );
  }
}
