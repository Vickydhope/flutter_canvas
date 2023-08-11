import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';
import 'package:flutter_canvas/res/num_duration_extensions.dart';

class FadingAppBarPage extends StatefulWidget {
  const FadingAppBarPage({Key? key}) : super(key: key);

  @override
  State<FadingAppBarPage> createState() => _FadingAppBarPageState();
}

class _FadingAppBarPageState extends State<FadingAppBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: _FadingAppBarDelegate(
              maxHeight: 250,
              minHeight: 120,
            ),
          ),
          const SliverToBoxAdapter(
            child: Text(
              "Quick brown fox jumps over the lazy dog!",
              style: TextStyle(fontSize: 150),
            ),
          )
        ],
      ),
    );
  }
}

class _FadingAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;

  _FadingAppBarDelegate({required this.maxHeight, required this.minHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;

    final percent = shrinkOffset / maxHeight;
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: AnimatedOpacity(
            opacity: ((1 - percent * 2)).clamp(0, 1),
            duration: 100.ms,
            child: Image.asset(
              Assets.imagesDubai,
              height: double.maxFinite,
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
