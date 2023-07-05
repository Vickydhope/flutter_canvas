import 'package:flutter_canvas/generated/assets.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/data/reviews.dart';

import 'review.dart';

class Location {
  final String title;
  final String addressLine1;
  final String addressLine2;
  final String image;
  final int stars;
  final double rating;
  final List<Review> reviews;

  Location({
    required this.title,
    required this.image,
    required this.addressLine1,
    required this.addressLine2,
    required this.stars,
    required this.rating,
    required this.reviews,
  });
}

List<Location> locations = [
  Location(
      title: "Phuket",
      image: Assets.imagesPhuket,
      stars: 4,
      rating: 4.1,
      addressLine1: 'Mueang Phuket District',
      addressLine2: ' Phuket 83000',
      reviews: Reviews.allReviews),
  Location(
      title: "Bali",
      image: Assets.imagesBali,
      stars: 4,
      rating: 3.9,
      addressLine1: 'Mahe, Praslin, La Digue, Beau Vallon',
      addressLine2: ' Goulue, La Perle Noire Restaurant,',
      reviews: Reviews.allReviews),
  Location(
      title: "Maldives",
      image: Assets.imagesMaldives,
      stars: 5,
      rating: 4.8,
      addressLine1: 'Magoodhoo',
      reviews: Reviews.allReviews,
      addressLine2: 'Maldives'),
  Location(
      title: "Seychelles",
      image: Assets.imagesSeychelle,
      stars: 3,
      reviews: Reviews.allReviews,
      rating: 3.5,
      addressLine1: 'Seychelles International',
      addressLine2: 'Seychelles'),
  Location(
      title: "Dubai",
      image: Assets.imagesDubai,
      stars: 4,
      rating: 4.4,
      addressLine1: 'United Arab Emirates',
      addressLine2: 'UAE',
      reviews: Reviews.allReviews),
];
