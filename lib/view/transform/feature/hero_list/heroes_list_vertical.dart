import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'hero_list_page.dart';

class HeroesListVertical extends StatelessWidget {
  const HeroesListVertical({
    Key? key,
    required this.animation,
  }) : super(key: key);
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
          itemCount: 4,
          itemBuilder: (context, index) => Row(
            children: [
              HeroCard(
                data: HeroData(
                  tag: "tag$index",
                  image: "assets/images/avatar-${index + 1}.png",
                  username: "username",
                  size: 75,
                ),
                onPressCard: (value) {},
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget? child) {
                    final newValue = (1.0 - animation.value) * size.width;
                    return FadeTransition(
                      opacity: CurvedAnimation(
                          curve: Interval(index / 8, 1), parent: animation),
                      child: Transform.translate(
                        offset: Offset(newValue, 0),
                        child: child,
                      ),
                    );
                  },
                  child: const Text("Quick brown fox jumps over the lazy dog!",
                      style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
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
            ..rotateX(newValue),
          child: current,
        );
      },
    );
  }

  Widget _scaleShuttleBuilder(flightContext, animation, flightDirection,
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
        final newValue = lerpDouble(0, pi * 2, animation.value) ?? 0.0;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..rotateY(newValue),
          child: current,
        );
      },
    );
  }
}
