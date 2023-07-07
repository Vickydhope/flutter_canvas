import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';
import 'package:flutter_canvas/res/app_colors.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/components/hero_widget.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/components/reviews_widget.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/data/hero_tag.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/data/reviews.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/model/location.dart';

import 'components/detailed_info_widget.dart';
import 'model/review.dart';

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
        body: CustomScrollView(slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: MediaQuery.of(context).size.height* .4,
            elevation: 0,
            backgroundColor: Colors.white,
            titleTextStyle:
                const TextStyle(color: Colors.black87, fontSize: 20),
            title: Text(location.title),
            centerTitle: true,
            floating: true,
            pinned: true,
            actions: [
              IconButton(
                color: Colors.black87,
                icon: const Icon(Icons.close),
                onPressed: Navigator.of(context).pop,
              ),
              const SizedBox(width: 10)
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox.expand(
                    child: Hero(
                      tag: HeroTag.image(location.image),
                      child: Image.asset(location.image, fit: BoxFit.cover),
                    ),
                  ),
                  /* Container(
                    padding: const EdgeInsets.all(8),
                    child: LatLongWidget(location: location),
                  ),*/
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DetailedInfoWidget(location: location),
          ),
          buildReviewsList()
        ]),
      );

  buildReviewsList() => SliverList.builder(
      itemBuilder: (context, index) {
        final review = location.reviews[index];

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) => FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: const Interval(0.2, 1, curve: Curves.easeInExpo),
            ),
            child: child,
          ),
          child: buildReview(review),
        );
      },
      itemCount: location.reviews.length);

  Widget buildReview(Review review) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                HeroWidget(
                  tag: HeroTag.avatar(review, locations.indexOf(location)),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.black12,
                    backgroundImage: AssetImage(review.urlImage),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  review.username,
                  style: const TextStyle(fontSize: 17),
                ),
                const Spacer(),
                const Spacer(),
                const Spacer(),
                Text(
                  review.date,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Icon(Icons.thumb_up_alt_outlined, size: 14)
              ],
            ),
            const SizedBox(height: 8),
            Text(
              review.description,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      );
}
