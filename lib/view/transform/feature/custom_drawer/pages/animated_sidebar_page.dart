import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_canvas/res/num_duration_extensions.dart';
import 'package:flutter_canvas/view/transform/feature/custom_drawer/pages/homepage.dart';

import '../components/info_card.dart';
import '../components/sidebar.dart';

class AnimateSideBarPage extends StatefulWidget {
  const AnimateSideBarPage({Key? key}) : super(key: key);

  @override
  State<AnimateSideBarPage> createState() => _AnimateSideBarPageState();
}

class _AnimateSideBarPageState extends State<AnimateSideBarPage>
    with TickerProviderStateMixin {
  late bool isMenuOpen = false;
  bool extendBody = false;

  late AnimationController _animationController;

  late Animation _animation;
  late Animation _scaleAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: 300.ms,
    )..addListener(() {
        setState(() {});
      });

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: extendBody,
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.blueGrey.shade900,
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, _animation.value * 125),
        child: NavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(CupertinoIcons.home),
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.search),
              label: "Search",
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.clock),
              label: "Reminders",
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.bell),
              label: "Notificaitons",
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.person),
              label: "Account",
            )
          ],
        ),
      ),
      body: Stack(children: [
        AnimatedPositioned(
          duration: 300.ms,
          curve: Curves.fastOutSlowIn,
          left: isMenuOpen ? 0 : -288,
          width: 288,
          height: MediaQuery.of(context).size.height,
          child: const Sidebar(),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_animation.value - 30 * _animation.value * pi / 180),
          child: Transform.translate(
            offset: Offset(_animation.value * 288, 0),
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_animation.value * 24),
                child: AbsorbPointer(
                  absorbing: isMenuOpen,
                  child: const HomePage(),
                ),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          left: isMenuOpen ? MediaQuery.of(context).size.width * 0.65 : 16,
          duration: 300.ms,
          curve: Curves.fastOutSlowIn,
          child: SafeArea(
            child: GestureDetector(
              onTap: () {
                if (isMenuOpen) {
                  _animationController.reverse().whenComplete(() {
                    setState(() {
                      extendBody = false;
                    });
                  });
                } else {
                  setState(() {
                    extendBody = true;
                  });
                  _animationController.forward();
                }
                setState(() {
                  isMenuOpen = !isMenuOpen;
                });
              },
              child: AnimatedContainer(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      spreadRadius: 5,
                      blurRadius: 50,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                duration: 300.ms,
                child: isMenuOpen
                    ? const Icon(
                        Icons.close,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.menu,
                        color: Colors.red,
                      ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
