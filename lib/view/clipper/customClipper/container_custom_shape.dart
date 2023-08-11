import 'package:flutter/material.dart';
import 'package:flutter_canvas/generated/assets.dart';

class CustomShapedContainer extends StatelessWidget {
  const CustomShapedContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Container(
            color: Colors.white,
            child: ClipPath(
              clipper: ContainerShapeClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                color: Colors.red,
                child: Image.asset(
                  Assets.imagesPhuket,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContainerShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final radiusFactor = size.width * 0.09;
    final Path path = Path();

    path.lineTo(0, size.height - 40);

    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);

    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);

    path.lineTo(size.width, 0);

    path.close();

    /*path.quadraticBezierTo(
      0,
      size.height / 2,
      radiusFactor,
      size.height - radiusFactor,
    );

    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width - radiusFactor,
      size.height - radiusFactor,
    );

    path.quadraticBezierTo(
      size.width,
      size.height / 2,
      size.width - radiusFactor,
      radiusFactor,
    );

    path.quadraticBezierTo(size.width / 2, 0, radiusFactor, radiusFactor);*/
/*

    path.lineTo(
      size.width,
      size.height - radiusFactor,
    );
*/

    /*  path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - radiusFactor,
    );*/

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return this != oldClipper;
  }
}
