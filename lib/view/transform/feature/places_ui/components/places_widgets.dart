import 'package:flutter/material.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/components/location_widget.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/model/location.dart';

class PlacesWidget extends StatefulWidget {
  const PlacesWidget({Key? key}) : super(key: key);

  @override
  State<PlacesWidget> createState() => _PlacesWidgetState();
}

class _PlacesWidgetState extends State<PlacesWidget> {
  final pageController = PageController(
    viewportFraction: 0.8,
  );
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: PageView.builder(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          itemCount: locations.length,
          itemBuilder: (context, index) {
            final location = locations[index];
            return LocationWidget(location: location);
          },
        )),
        Text(
          "${pageIndex + 1}/${locations.length}",
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        )
      ],
    );
  }
}
