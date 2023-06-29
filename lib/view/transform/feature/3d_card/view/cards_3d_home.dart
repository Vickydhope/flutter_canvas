import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';
import 'package:flutter_canvas/main.dart';
import 'package:flutter_canvas/view/transform/feature/3d_card/view/3D_card_details.dart';
import 'package:go_router/go_router.dart';

import '../data/model/card3d.dart';

class Cards3DHome extends StatelessWidget {
  const Cards3DHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("3D Cards"),
      ),
      body: const Column(
        children: [
          Expanded(
            flex: 3,
            child: CardBody(),
          ),
          Expanded(
            flex: 2,
            child: CardsHorizontal(),
          ),
        ],
      ),
    );
  }
}

class CardsHorizontal extends StatelessWidget {
  const CardsHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Recently Played,"),
          Expanded(
              child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.all(10.0),
              child: Card3dWidget(),
            ),
          ))
        ],
      ),
    );
  }
}

class Card3dWidget extends StatelessWidget {
  const Card3dWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var border = BorderRadius.circular(15);
    return PhysicalModel(
      color: Colors.white,
      borderRadius: border,
      elevation: 10,
      child: ClipRRect(
        borderRadius: border,
        child: Image.asset(
          Assets.imagesImg,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class CardBody extends StatefulWidget {
  const CardBody({Key? key}) : super(key: key);

  @override
  State<CardBody> createState() => _CardBodyState();
}

class _CardBodyState extends State<CardBody> with TickerProviderStateMixin {
  bool _selectedMode = false;
  late AnimationController _animationControllerSelection;
  late AnimationController _animationControllerMovement;
  int? _selectedIndex;

  FutureOr<void> _onCardSelected(Card3d card, int index) async {
    setState(() {
      _selectedIndex = index;
    });
    _animationControllerMovement.forward();
    await context.pushNamed(AppRoutes.cardDetails.name, extra: card);
    _animationControllerMovement.reverse(from: 1.0);
  }

  @override
  void initState() {
    _animationControllerSelection = AnimationController(
      vsync: this,
      lowerBound: 0.15,
      upperBound: 0.5,
      duration: const Duration(milliseconds: 300),
    );
    _animationControllerMovement = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationControllerSelection.dispose();
    _animationControllerMovement.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        var selectionValue = _animationControllerSelection.value;

        return LayoutBuilder(
          builder: (context, constraints) {
            return GestureDetector(
              onTap: () {
                if (!_selectedMode) {
                  _animationControllerSelection.forward().whenComplete(() {
                    setState(() {
                      _selectedMode = true;
                    });
                  });
                } else {
                  _animationControllerSelection.reverse().whenComplete(() {
                    setState(() {
                      _selectedMode = false;
                    });
                  });
                }
              },
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(selectionValue),
                child: AbsorbPointer(
                  absorbing: !_selectedMode,
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(top: 26),
                    height: constraints.maxHeight,
                    width: constraints.maxWidth * 0.45,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: List.generate(
                        4,
                        (index) => Card3dItem(
                          animation: _animationControllerMovement,
                          card: Card3d(title: "hero$index"),
                          depth: index,
                          height: constraints.maxHeight / 2,
                          percentage: selectionValue,
                          verticalFactor: _getCurrentFactor(index),
                          onCardSelected: (card) {
                            _onCardSelected(card, index);
                          },
                        ),
                      ).reversed.toList(),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      animation: _animationControllerSelection,
    );
  }

  int _getCurrentFactor(int currentIndex) {
    if (_selectedIndex == null || currentIndex == _selectedIndex) {
      return 0;
    } else if (currentIndex > _selectedIndex!) {
      return -1;
    } else {
      return 1;
    }
  }
}

class Card3dItem extends AnimatedWidget {
  const Card3dItem({
    Key? key,
    required this.height,
    required this.percentage,
    required this.depth,
    required this.card,
    required this.onCardSelected,
    this.verticalFactor = 0,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  final double height;
  final double percentage;
  final int depth;
  final Card3d card;
  final int verticalFactor;
  final ValueChanged<Card3d> onCardSelected;

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    const depthFactor = 50.0;
    final bottomMargin = height / 5;

    return Positioned(
      left: 0,
      right: 0,
      top: height + (-depth * height / 2.0 * percentage) - bottomMargin,
      child: Opacity(
        opacity: verticalFactor == 0 ? 1 : 1 - animation.value,
        child: Hero(
          tag: card.title,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value * pi / 5)
              ..translate(
                0.0,
                verticalFactor *
                    animation.value *
                    MediaQuery.of(context).size.height,
                depth * depthFactor,
              ),
            child: GestureDetector(
              onTap: () {
                onCardSelected(card);
              },
              child: SizedBox(
                height: height,
                child: const Card3dWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
