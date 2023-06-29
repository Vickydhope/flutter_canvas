import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.green;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();
    path
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - size.width * 0.1, size.height)
      ..lineTo(size.width - size.width * 0.1, size.height * .55)
      ..quadraticBezierTo(
        size.width - size.width * 0.3,
        size.height / 2,
        size.width - size.width * 0.1,
        size.height * 0.45,
      )
      ..lineTo(size.width - size.width * 0.1, 0);
/*
    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);*/
    // path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
