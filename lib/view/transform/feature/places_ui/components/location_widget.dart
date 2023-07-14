import 'package:flutter/material.dart';
import 'package:flutter_canvas/res/num_duration_extensions.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/components/expanded_content_widget.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/components/image_widget.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/data/hero_tag.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/place_details_page.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/model/location.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({
    Key? key,
    required this.location,
  }) : super(key: key);

  final Location location;

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: 300.ms,
            bottom: isExpanded ? 40 : 100,
            width: isExpanded ? size.width * 0.78 : size.width * 0.7,
            height: isExpanded ? size.height * 0.6 : size.height * 0.5,
            child: ExpandedContentWidget(location: widget.location),
          ),
          AnimatedPositioned(
            duration: 300.ms,
            bottom: isExpanded ? 150 : 100,
            child: GestureDetector(
              onPanUpdate: onPanUpdate,
              onTap: openDetailsPage,
              child: ImageWidget(
                location: widget.location,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < -5) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 5) {
      setState(() {
        isExpanded = false;
      });
    }
  }

  openDetailsPage() {
    if (!isExpanded) {
      setState(() {
        isExpanded = true;
      });
    } else {
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: 450.ms,
          reverseTransitionDuration: 450.ms,
          pageBuilder: (context, animation, secondaryAnimation) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: const Interval(0, 0.5),
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: PlaceDetailsPage(
                location: widget.location,
                animation: animation,
              ),
            );
          },
        ),
      );
    }
  }
}
