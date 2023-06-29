import 'package:flutter/material.dart';
import 'package:flutter_canvas/model/slider_model.dart';
import 'package:flutter_canvas/paint/curve_painter.dart';
import 'package:flutter_canvas/widget/slider.dart' as slider;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  List<SliderModel> slides = <SliderModel>[];
  int currentIndex = 0;
  late PageController _controller;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    slides = getSlides();
    _animationController = AnimationController(vsync: this);

    //Dot width
    _controller.addListener(() {
      //Color value
      _animationController.value = _controller.offset /
          (MediaQuery.of(context).size.width * (slides.length - 1));
      // print(_animationController.value);
    });
  }

  Animatable<Color?> background = TweenSequence<Color?>([
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: const Color(0xFFD0C2F9),
        end: const Color(0xFFCBEEE7),
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: const Color(0xFFCBEEE7),
        end: const Color(0xFF98DFD5),
      ),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: const Color(0xFF98DFD5),
        end: const Color(0xFFFFADC4),
      ),
    ),
  ]);

  Animatable<double?> dotWidth = TweenSequence<double?>([
    TweenSequenceItem(
      weight: 1.0,
      tween: Tween(begin: 10, end: 50),
    ),
    /*TweenSequenceItem(
      weight: 1.0,
      tween: Tween(begin: 10, end: 50),
    ),*/
  ]);

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  itemCount: slides.length,
                  itemBuilder: (context, index) {
                    // contents of slider
                    return slider.Slider(
                      image: slides[index].getImage(),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomInkWell(
                      padding: 10,
                      onTap: currentIndex == 0
                          ? null
                          : () {
                              _controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInCubic);
                            },
                      child: Icon(
                        Icons.arrow_back,
                        color: currentIndex == 0
                            ? Colors.transparent
                            : Colors.teal,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      slides.length,
                      (index) => buildDot(index, context),
                    ),
                  ),
                  AnimatedCrossFade(
                    firstChild: CustomInkWell(
                        padding: 10,
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInCubic);
                        },
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.teal,
                        )),
                    secondChild: CustomInkWell(
                        padding: 10,
                        onTap: () {},
                        child: const Icon(
                          Icons.done_rounded,
                          color: Colors.teal,
                        )),
                    crossFadeState: currentIndex == slides.length - 1
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(microseconds: 300),
                  ),
                  /*IconButton(
                      onPressed: () {}, icon: const Icon(Icons.arrow_forward)),*/
                ],
              ),
            ),
          ],
        ),
        backgroundColor: background
            .evaluate(AlwaysStoppedAnimation(_animationController.value)),
      ),
    );
  }

  List<AnimationController> animController = [];

// container created for dots
  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 5,
      width: currentIndex == index ? 40 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Colors.teal : Colors.grey.shade300,
      ),
    );
  }
}

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    Key? key,
    required this.child,
    this.onTap,
    this.padding = 0,
    this.borderRadius = 100,
  }) : super(key: key);
  final Function()? onTap;
  final Widget child;
  final double borderRadius;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ));
  }
}
