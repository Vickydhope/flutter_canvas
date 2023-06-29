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
              child: const Card3dWidget(),
            ),
          )),
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

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final newValue = lerpDouble(0.0, 2 * pi, animation.value) ?? 0.0;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(newValue)/*
            ..rotateX(newValue)*/,
          child: current,
        );
      },
    );
  }
}
