import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';

class BlackHoleAnimationPage extends StatefulWidget {
  const BlackHoleAnimationPage({Key? key}) : super(key: key);

  @override
  State<BlackHoleAnimationPage> createState() => _BlackHoleAnimationPageState();
}

class _BlackHoleAnimationPageState extends State<BlackHoleAnimationPage>
    with TickerProviderStateMixin {
  final cardSize = 150.0;

  late final holeSizeTween = Tween<double>(
    begin: 0,
    end: 1.9 * cardSize,
  );
  late final holeAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late final cardOffsetAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );

  late final cardOffsetTween = Tween<double>(
    begin: 0,
    end: cardSize * 1.45,
  ).chain(CurveTween(curve: Curves.easeInBack));

  late final cardRotationTween = Tween<double>(
    begin: 0,
    end: 0.7,
  ).chain(CurveTween(curve: Curves.easeInBack));

  late final cardElevationTween = Tween<double>(
    begin: 2,
    end: 20,
  );

  double get holeSize => holeSizeTween.evaluate(holeAnimationController);

  double get cardOffset =>
      cardOffsetTween.evaluate(cardOffsetAnimationController);

  double get cardRotation =>
      cardRotationTween.evaluate(cardOffsetAnimationController);

  double get cardElevation =>
      cardElevationTween.evaluate(cardOffsetAnimationController);

  @override
  void initState() {
    holeAnimationController.addListener(() => setState(() {}));
    cardOffsetAnimationController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    holeAnimationController.dispose();
    cardOffsetAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "decrement",
            onPressed: () async {
              if (cardOffsetAnimationController.value > 0) return;
              holeAnimationController.forward();
              await cardOffsetAnimationController.forward();
              Future.delayed(
                const Duration(milliseconds: 200),
                () => holeAnimationController.reverse(),
              );
            },
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            heroTag: "increment",
            onPressed: () {
              cardOffsetAnimationController.reverse();
              holeAnimationController.reverse();
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: cardSize * 1.5,
          width: double.infinity,
          child: ClipPath(
            clipper: BlackHoleClipper(),
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  width: holeSize,
                  child: Image.asset(
                    Assets.imagesHole,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 35,
                  child: Center(
                    child: Transform.translate(
                      offset: Offset(0, cardOffset),
                      child: Transform.rotate(
                        angle: cardRotation,
                        child: HelloWorldCard(
                          size: cardSize,
                          elevation: cardElevation,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HelloWorldCard extends StatelessWidget {
  const HelloWorldCard({
    Key? key,
    required this.size,
    required this.elevation,
  }) : super(key: key);

  final double size;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(10),
      child: SizedBox.square(
        dimension: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: const Center(
            child: Text(
              'Hello\nWorld',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

class BlackHoleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height / 2);
    path.arcTo(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width,
        height: size.height,
      ),
      0,
      pi,
      true,
    );
    // Using -1000 guarantees the card won't be clipped at the top, regardless of its height
    path.lineTo(0, -1000);
    path.lineTo(size.width, -1000);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(BlackHoleClipper oldClipper) => false;
}
