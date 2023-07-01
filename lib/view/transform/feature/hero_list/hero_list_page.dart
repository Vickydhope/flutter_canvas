import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';
import 'package:flutter_canvas/main.dart';
import 'package:go_router/go_router.dart';

class HeroListPage extends StatelessWidget {
  const HeroListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Stack(
              children: [
                ...List.generate(
                  3,
                  (index) => Padding(
                    padding: EdgeInsets.only(left: index * 40.0),
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoutes.heroListVertical.name);
                      },
                      child: HeroCard(
                          data: HeroData(
                            tag: "tag$index",
                            image: "assets/images/avatar-${index + 1}.png",
                            username: "username",
                            size: 50,
                          ),
                          onPressCard: (value) {}),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeroCard extends StatelessWidget {
  const HeroCard({
    Key? key,
    required this.data,
    required this.onPressCard,
  }) : super(key: key);
  final HeroData data;

  final ValueChanged<HeroData> onPressCard;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: data.tag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(data.size / 2),
        child: Container(
          child: Image.asset(
            data.image,
            height: data.size,
            width: data.size,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class HeroData {
  final String tag;
  final String image;
  final String username;
  final double size;

  HeroData({
    required this.tag,
    required this.image,
    required this.username,
    this.size = 50,
  });
}
