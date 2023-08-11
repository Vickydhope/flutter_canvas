import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';

class CustomClipperPage extends StatelessWidget {
  const CustomClipperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: () {},
        child: PageView.builder(
          itemCount: 4,
          itemBuilder: (context, index) => Center(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipPath(
                  clipper: BackGroundClipper(),
                  child: Container(
                    height: size.height * 0.6,
                    width: size.width * 0.8,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange,
                          Colors.orangeAccent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topLeft,
                      ),
                    ),
                  ),
                ),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundImage: AssetImage(Assets.imagesAvatar2),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "John Palmer",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackGroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    print(15 / size.width);
    const roundFactor = 50.0;
    final path = Path();

    path.moveTo(0, size.height * 0.33);
    path.lineTo(0, size.height - roundFactor); //   point 0

    path.quadraticBezierTo(0, size.height, roundFactor,
        size.height); // (x1,y1) => p1 ; (x2,y2) => p2 ;

    path.lineTo(size.width - roundFactor, size.height);

    path.quadraticBezierTo(size.width, size.height, size.width,
        size.height - roundFactor); // (x1,y1) => p1 ; (x2,y2) => p2 ;

    path.lineTo(size.width, roundFactor);

    path.quadraticBezierTo(
        size.width, 0, size.width - roundFactor, size.height * 0.035);

    path.lineTo(30, size.height * 0.25);

    path.quadraticBezierTo(0, size.height * 0.28, 0, size.height * 0.33);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
