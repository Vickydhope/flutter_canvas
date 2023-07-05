import 'package:flutter/material.dart';

import '../data/hero_tag.dart';
import '../model/location.dart';
import 'hero_widget.dart';
import 'star_widget.dart';
class DetailedInfoWidget extends StatelessWidget {
  final Location location;

  const DetailedInfoWidget({
    required this.location,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroWidget(
          tag: location.title,
          child: Text(location.title),
        ),
        const SizedBox(height: 8),
        HeroWidget(
          tag: HeroTag.addressLine1(location),
          child: Text("${location.addressLine1}, ${location.addressLine2}",maxLines: 1,),
        ),
        const SizedBox(height: 8),
        HeroWidget(
          tag: HeroTag.stars(location),
          child: StarWidget(stars: location.stars),
        ),
      ],
    ),
  );
}