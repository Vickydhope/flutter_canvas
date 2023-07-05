import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/components/star_widget.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/data/hero_tag.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/data/reviews.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/model/location.dart';

import 'hero_widget.dart';

class ExpandedContentWidget extends StatelessWidget {
  const ExpandedContentWidget({Key? key, required this.location})
      : super(key: key);

  final Location location;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            HeroWidget(
              tag: location.title,
              child: Text(
                location.title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            buildAddressRating(),
            const SizedBox(height: 8),
            buildReview(location),
          ],
        ),
      );

  Widget buildAddressRating() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: HeroWidget(
              tag: HeroTag.addressLine1(location),
              child: Text(
                "${location.addressLine1}, ${location.addressLine2}",
                maxLines: 1,
                style: const TextStyle(color: Colors.black45),
              ),
            ),
          ),
          HeroWidget(
              tag: HeroTag.stars(location), child: StarWidget(stars: location.stars)),
        ],
      );

  Widget buildReview(Location location) {
    return Row(
      children: location.reviews.map((review) {
        final pageIndex = locations.indexOf(location);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: HeroWidget(
            tag: HeroTag.avatar(review, pageIndex),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.black12,
              backgroundImage: AssetImage(review.urlImage),
            ),
          ),
        );
      }).toList(),
    );
  }
}
