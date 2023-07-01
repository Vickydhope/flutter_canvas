import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_canvas/main.dart';
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Recently Played,",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey.shade700),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _getCards().length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card3dWidget(
                  card: _getCards()[index],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Card3dWidget extends StatelessWidget {
  const Card3dWidget({Key? key, required this.card}) : super(key: key);

  final Card3d card;

  @override
  Widget build(BuildContext context) {
    var border = BorderRadius.circular(15);
    return PhysicalModel(
      color: Colors.white,
      borderRadius: border,
      elevation: 10,
      child: ClipRRect(
        borderRadius: border,
        child: Image.network(
          card.image,
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
                        _getCards().length,
                        (index) => Card3dItem(
                          animation: _animationControllerMovement,
                          card: _getCards()[index],
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
      top: height + (-depth * height / 1.8 * percentage) - bottomMargin,
      child: Opacity(
        opacity: verticalFactor == 0 ? 1 : 1 - animation.value,
        child: Hero(
          tag: card.title,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
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
                child: Card3dWidget(
                  card: card,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<Card3d> _getCards() => [
      Card3d(
        title: "Falling",
        image:
            "https://marketplace.canva.com/EAEqlr422aw/1/0/1600w/canva-falling-modern-aesthetic-music-album-cover-KsRCFSNg4XA.jpg",
      ),
      Card3d(
        title: "Cloud",
        image:
            "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/pink-cloud-cd-cover-music-design-template-258c703e9959b4635649e3944488c688_screen.jpg?ts=1631060402",
      ),
      Card3d(
        title: "3Force",
        image:
            "https://mir-s3-cdn-cf.behance.net/project_modules/hd/c516f191023435.5e270367679f1.png",
      ),
      Card3d(
        title: "Miami Horror Illumination",
        image:
            "https://e.snmc.io/i/1200/s/9114e01b9bce4d4e819641b9feda3344/4151122",
      ),
    ];
