import 'package:flutter/material.dart';

class Slider extends StatelessWidget {
  String image;

  Slider({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // image given in slider
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(
                    MediaQuery.of(context).size.shortestSide * 0.09),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16)),
                child: Image(
                  image: AssetImage(
                    image,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 0),
      ],
    );
  }
}
