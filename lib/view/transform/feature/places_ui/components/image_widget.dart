import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/data/hero_tag.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/model/location.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.location,
  }) : super(key: key);
  final Location location;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Hero(
      tag: HeroTag.image(location.image),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        height: size.height * 0.5,
        width: size.width * 0.8,
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 2, spreadRadius: 1),
            ],
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Stack(
            children: [
              SizedBox.expand(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(location.image, fit: BoxFit.cover),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
