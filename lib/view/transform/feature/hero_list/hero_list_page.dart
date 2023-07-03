import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';
import 'package:flutter_canvas/main.dart';
import 'package:flutter_canvas/res/num_duration_extensions.dart';
import 'package:flutter_canvas/view/transform/feature/hero_list/heroes_list_vertical.dart';
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
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            child: Center(
              child: Stack(
                children: [
                  ...List.generate(
                    8,
                    (index) => Padding(
                      padding: EdgeInsets.only(left: index * 40.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            transitionDuration: 750.ms,
                            reverseTransitionDuration: 750.ms,
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    FadeTransition(
                              opacity: CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.fastEaseInToSlowEaseOut),
                              child: HeroesListVertical(animation: animation),
                            ),
                          ));
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
      flightShuttleBuilder: data.flightShuttleBuilder,
      tag: data.tag,
      child: Container(
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(data.size * 2),
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

  final Widget Function(
      dynamic flightContext,
      dynamic animation,
      dynamic flightDirection,
      dynamic fromHeroContext,
      dynamic toHeroContext)? flightShuttleBuilder;

  HeroData({
    required this.tag,
    required this.image,
    required this.username,
    this.size = 50,
    this.flightShuttleBuilder,
  });
}
