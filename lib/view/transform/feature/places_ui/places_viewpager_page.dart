import 'package:flutter/material.dart';
import 'package:flutter_canvas/view/transform/feature/places_ui/components/places_widgets.dart';

class PlacesViewPagerPage extends StatelessWidget {
  const PlacesViewPagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: buildAppBar(),
      bottomNavigationBar: buildBottomNavigation(),
      body: const PlacesWidget(),
    );
  }

  AppBar buildAppBar() => AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text('INTERESTS'),
      centerTitle: true,
      actions: [
        IconButton(icon: const Icon(Icons.location_pin), onPressed: () {})
      ],
      leading: IconButton(
          icon: const Icon(Icons.search_outlined), onPressed: () {}));

  Widget buildBottomNavigation() => BottomNavigationBar(
        elevation: 0,
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '',
          ),
        ],
      );
}
