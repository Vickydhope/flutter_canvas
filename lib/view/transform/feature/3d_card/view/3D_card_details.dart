import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_canvas/view/transform/feature/3d_card/view/cards_3d_home.dart';

import '../data/model/card3d.dart';

class CardDetailsPage extends StatelessWidget {
  const CardDetailsPage({
    Key? key,
    required this.card,
  }) : super(key: key);

  final Card3d card;

  @override
  Widget build(BuildContext context) {
    print("CardDetailsPage : ${card.title}");
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Align(
              child: SizedBox(
            height: 250,
            child: Hero(
              flightShuttleBuilder: _flightShuttleBuilder,
              tag: card.title,
              child: Card3dWidget(card: card),
            ),
          )),
          const Spacer(),
          TweenAnimationBuilder(
            curve: Curves.easeInOut,
              tween: Tween<double>(begin: 1.0, end: 0.0),
              duration: const Duration(milliseconds: 750),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0.0, value * 100),
                  child: child,
                );
              },
              child: _buildPlayerControls()),
        ],
      ),
    );
  }

  Widget _flightShuttleBuilder(flightContext, animation, flightDirection,
      fromHeroContext, toHeroContext) {
    Widget current;
    if (flightDirection == HeroFlightDirection.push) {
      current = toHeroContext.widget;
    } else {
      current = fromHeroContext.widget;
    }

    print(animation.toString());
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final newValue = lerpDouble(0.0, 2 * pi, animation.value) ?? 0.0;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0015)
            ..rotateX(newValue),
          child: current,
        );
      },
    );
  }

  Widget _buildPlayerControls() {
    return Column(
      children: [
        Text(
          card.title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.orange,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.skip_previous,
                size: 35,
              ),
              Icon(
                Icons.play_circle_rounded,
                size: 50,
              ),
              Icon(
                Icons.skip_next,
                size: 35,
              ),
            ],
          ),
        )
      ],
    );
  }
}
