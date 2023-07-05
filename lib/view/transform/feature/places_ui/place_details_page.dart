import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/components/reviews_widget.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/data/hero_tag.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/data/reviews.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/model/location.dart';

import 'components/detailed_info_widget.dart';

class PlaceDetailsPage extends StatelessWidget {
  final Location location;

  const PlaceDetailsPage({
    Key? key,
    required this.location,
    required this.animation,
  }) : super(key: key);
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text('INTERESTS'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: Navigator.of(context).pop,
            ),
            const SizedBox(width: 10)
          ],
          leading: const Icon(Icons.search_outlined),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox.expand(
                    child: Hero(
                      tag: HeroTag.image(location.image),
                      child: Image.asset(location.image, fit: BoxFit.cover),
                    ),
                  ),
                  /*  Container(
                padding: const EdgeInsets.all(8),
                child: LatLongWidget(location: location),
              ),*/
                ],
              ),
            ),
            DetailedInfoWidget(location: location),
            Expanded(flex: 5, child: ReviewsWidget(location: location,animation : animation)),
          ],
        ),
      );
}
