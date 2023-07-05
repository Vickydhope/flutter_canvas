import 'package:flutter/material.dart';

class StarWidget extends StatelessWidget {
  final int stars;

  const StarWidget({
    Key? key,
    required this.stars,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allStars = List.generate(stars, (index) => index);

    return Row(
      children: allStars
          .map((star) => Container(
                margin: const EdgeInsets.only(right: 4),
                child: const Icon(
                  Icons.star_rate,
                  color: Colors.blueGrey,
                  size: 18,
                ),
              ))
          .toList(),
    );
  }
}
