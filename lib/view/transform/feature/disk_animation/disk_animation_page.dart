import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';
import 'package:vector_math/vector_math.dart' as vector;

class DiskAnimationPage extends StatelessWidget {
  const DiskAnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverPersistentHeader(
          delegate: _MyDiskHeaderDelegate(),
          pinned: true,
          floating: true,
        ),
        const SliverToBoxAdapter(
          child: Text(
            "Quick brown fox jumps over the lazy dog!",
            style: TextStyle(fontSize: 150),
          ),
        )
      ]),
    );
  }
}

const _colorHeader = Color(0xFFECECEA);
const _maxHeaderExtent = 350.0;
const _minHeaderExtent = 160.0;

const _maxImageSize = 150.0;
const _minImageSize = 100.0;

const _leftMarginDisk = 150.0;

const _maxTitleSize = 25.0;
const _maxSubTitleSize = 18.0;

const _minTitleSize = 20.0;
const _minSubTitleSize = 15.0;

class _MyDiskHeaderDelegate extends SliverPersistentHeaderDelegate {

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / _maxHeaderExtent;
    final size = MediaQuery.of(context).size;

    final currentImageSize =
        ((_maxImageSize * (1 - percent))).clamp(_minImageSize, _maxImageSize);

    final titleSize =
        (_maxTitleSize * (1 - percent)).clamp(_minTitleSize, _maxTitleSize);

    final subTitleSize = (_maxSubTitleSize * (1 - percent))
        .clamp(_minSubTitleSize, _maxSubTitleSize);

    final maxMargin = size.width / 3;
    const textMovement = 52.0;

    final leftTextMargin = maxMargin + (textMovement * percent);


    return Container(
      color: _colorHeader,
      child: Stack(alignment: Alignment.center, children: [
        Positioned(
          top: 65,
          left: leftTextMargin,
          height: _maxImageSize,
          child: Column(
            children: [
              Text(
                "Dexter Gordon",
                style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5),
              ),
              Text(
                "Our Man in Paris",
                style: TextStyle(
                    fontSize: subTitleSize,
                    color: Colors.grey,
                    letterSpacing: -0.5),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 22,
          left: (_leftMarginDisk * (1 - percent)).clamp(35.0, _leftMarginDisk),
          child: Transform.rotate(
            angle: vector.radians(360 * percent),
            child: Image.asset(
              Assets.imagesDisk,
              fit: BoxFit.cover,
              height: currentImageSize - 5,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 35,
          child: Image.asset(
            Assets.imagesAlbumCover,
            fit: BoxFit.cover,
            height: currentImageSize,
          ),
        ),
      ]),
    );
  }

  @override
  double get maxExtent => _maxHeaderExtent;

  @override
  double get minExtent => _minHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
