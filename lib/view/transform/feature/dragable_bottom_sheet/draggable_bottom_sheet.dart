import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';
import 'package:flutter_canvas/res/num_duration_extensions.dart';

class DraggableBottomSheet extends StatefulWidget {
  const DraggableBottomSheet({Key? key}) : super(key: key);

  @override
  State<DraggableBottomSheet> createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  double _percent = 0.0;

  late final DraggableScrollableController _draggableScrollableController;

  @override
  void initState() {
    _draggableScrollableController = DraggableScrollableController();
    super.initState();
  }

  @override
  void dispose() {
    _draggableScrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topSectionHeight = MediaQuery.of(context).size.height * 0.3;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: MediaQuery.of(context).size.height * 0.2,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(_percent * 0.8), BlendMode.srcOver),
              child: Image.asset(
                Assets.imagesMap,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: kToolbarHeight,
            left: 20,
            child: FloatingActionButton(
              onPressed: () {
                _draggableScrollableController.animateTo(
                  0.81,
                  duration: 300.ms,
                  curve: Curves.easeOutSine,
                );
              },
              child: const Icon(Icons.menu),
            ),
          ),
          Positioned.fill(
            child: NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                setState(() {
                  _percent = (notification.extent - 0.4) / (0.81 - 0.4);
                });

                return true;
              },
              child: DraggableScrollableSheet(
                controller: _draggableScrollableController,
                snap: true,
                maxChildSize: 0.81,
                minChildSize: 0.4,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Material(
                    color: Colors.white,
                    elevation: 10,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Align(
                            child: Container(
                              width: 50,
                              height: 3,
                              color: Colors.grey,
                            ),
                          ),
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
                          const SizedBox(height: 30),
                          TextField(
                            decoration: InputDecoration(
                              filled: true,
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                              fillColor: Colors.grey.shade100,
                              hintText: "Search Destination",
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: Colors.purple[300],
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                              child: ListView.builder(
                            controller: scrollController,
                            padding: EdgeInsets.zero,
                            itemCount: 2,
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
            top: -(topSectionHeight * (1 - _percent)),
            left: 0,
            right: 0,
            height: topSectionHeight,
            child: Container(
              color: Colors.white,
              child: _SearchDestinations(onBackPress: () {
                _draggableScrollableController.animateTo(
                  0.4,
                  duration: 300.ms,
                  curve: Curves.easeOutSine,
                );
              }),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: -50 * (1 - _percent),
            child: Container(
              color: Colors.green,
              height: 50,
              child: const Center(
                  child: Text(
                "Pick on map",
                style: TextStyle(fontSize: 18, color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }




}

class _SearchDestinations extends StatelessWidget {
  const _SearchDestinations({
    Key? key,
    required this.onBackPress,
  }) : super(key: key);

  final Function() onBackPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.4),
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(children: [
              IconButton(
                  onPressed: onBackPress,
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                  )),
              const Text(
                "Choose Destination",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ]),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.transparent)),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.transparent)),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Enter your location.",
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.transparent)),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.transparent)),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Where are we going?",
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
