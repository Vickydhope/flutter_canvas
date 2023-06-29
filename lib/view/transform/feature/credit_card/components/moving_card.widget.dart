import 'dart:math';

import 'package:flutter/material.dart';

class MovingCardWidget extends StatefulWidget {
  final String urlFront;
  final String urlBack;

  const MovingCardWidget({
    Key? key,
    required this.urlBack,
    required this.urlFront,
  }) : super(key: key);

  @override
  State<MovingCardWidget> createState() => _MovingCardWidgetState();
}

class _MovingCardWidgetState extends State<MovingCardWidget>
    with TickerProviderStateMixin {
  bool isFront = true;
  double verticalDrag = 0; // CardPosition
  double _value = 0; //Slider value

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onVerticalDragEnd: (details) {
              final double end = 360 - verticalDrag >= 180 ? 0 : 360;
              animation = Tween<double>(begin: verticalDrag, end: end)
                  .animate(controller)
                ..addListener(() {
                  setState(() {
                    verticalDrag = animation.value;
                    setImageSide();
                  });
                });
              controller.forward();
            },
            onVerticalDragStart: (details) {
              controller.reset();
              setState(() {
                isFront = true;
                verticalDrag = 0;
              });
            },
            onVerticalDragUpdate: (details) {
              setState(() {
                verticalDrag += details.delta.dy;
                verticalDrag %= 360;
                setImageSide();
              });
            },
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0005)
                ..rotateX(verticalDrag / 180 * pi),
              alignment: Alignment.center,
              child: isFront
                  ? Image.asset(widget.urlFront)
                  : Transform(
                      transform: Matrix4.identity()..rotateY(pi),
                      alignment: Alignment.center,
                      child: Image.asset(widget.urlBack),
                    ),
            ),
          ),
        ),
        Slider(
          value: verticalDrag/360,
          min: 0,
          max: 1,
          onChanged: (value) {
            setState(() {
              _value = value;
              verticalDrag = _value * 360;
            });
          },
        ),
        Text("$verticalDrag")
      ],
    );
  }

  void setImageSide() {
    if (verticalDrag <= 90 || verticalDrag >= 270) {
      isFront = true;
    } else {
      isFront = false;
    }
  }
}
