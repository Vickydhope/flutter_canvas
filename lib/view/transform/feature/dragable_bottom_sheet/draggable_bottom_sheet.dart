import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';

class DraggableBottomSheet extends StatefulWidget {
  const DraggableBottomSheet({Key? key}) : super(key: key);

  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  double _percent = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: MediaQuery.of(context).size.height * 0.2,
            child: Image.asset(
              Assets.imagesMap,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: kToolbarHeight,
            left: 20,
            child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.menu),
            ),
          ),
          Positioned.fill(
            child: NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                setState(() {
                  _percent = 2 * notification.extent - 0.8;
                });

                return true;
              },
              child: DraggableScrollableSheet(
                snap: true,
                maxChildSize: 0.9,
                minChildSize: 0.4,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Material(
                    color: Colors.white,
                    elevation: 10,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            "It's good to see you.",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Where are you going?",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 25),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Search Destination",
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: Colors.purple[300],
                              ),
                            ),
                          ),
                          Expanded(
                              child: ListView.builder(
                            controller: scrollController,
                            padding: EdgeInsets.zero,
                            itemCount: 40,
                            itemBuilder: (context, index) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.location_on_rounded),
                              title: Text("Item $index"),
                            ),
                          ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: -170 * (1 - _percent),
            left: 0,
            right: 0,
            child: const _SearchDestinations(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -50 * (1 - _percent),
            child: Container(
              color: Colors.grey,
              height: 50,
              child: const Center(child: Text("Pick on map")),
            ),
          )
        ],
      ),
    );
  }
}

class _SearchDestinations extends StatelessWidget {
  const _SearchDestinations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      child: Column(
        children: [
          Row(children: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_new)),
            const Text(
              "Choose Destination",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ]),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(hintText: "Enter your location."),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Where are we going?"),
                ),
                SizedBox(height: 16),
              ],
            ),
          )
        ],
      ),
    );
  }
}
