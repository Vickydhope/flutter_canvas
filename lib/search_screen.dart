import 'package:flutter/material.dart';
import 'package:flutter_canvas/view/transform/feature/3d_card/view/cards_3d_home.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          const Align(
              child: SizedBox(
            height: 150,
            child: Hero(
              tag: "image",
              child: Card3dWidget(),
            ),
          )),
        ],
      ),
    );
  }
}
