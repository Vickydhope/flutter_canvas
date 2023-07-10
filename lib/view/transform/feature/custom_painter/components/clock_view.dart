import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_canvas/res/num_duration_extensions.dart';
import 'package:intl/intl.dart';

class ClockView extends StatefulWidget {
  const ClockView({Key? key}) : super(key: key);

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    setState(() {
      Timer.periodic(1.seconds, (timer) {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 300,
          width: 300,
          child: Transform.rotate(
            angle: -pi / 2,
            child: CustomPaint(
              painter: ClockPainter(),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          DateFormat('hh:mm aa').format(DateTime.now()),
          style: const TextStyle(
              color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);

    final radius = min(centerX, centerY);
    var fillBrush = Paint()..color = const Color(0xFF444974);
    var outlineBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var centerFilledBrush = Paint()..color = const Color(0xFFEAECFF);

    var secHandBrush = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var minHandBrush = Paint()
      ..shader = const RadialGradient(colors: [
        Color(0xFF748EF6),
        Color(0xFF77DDFF),
      ]).createShader(Rect.fromCircle(center: center, radius: radius))
      ..color = Colors.orange
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    var hourHandBrush = Paint()
      ..shader = const RadialGradient(colors: [
        Color(0xFFEA74AB),
        Color(0xFFC279FB),
      ]).createShader(Rect.fromCircle(center: center, radius: radius))
      ..color = Colors.orange
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var hourHandX = centerX +
        50 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        50 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);

    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + 70 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 70 * sin(dateTime.minute * 6 * pi / 180);

    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + 85 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 85 * sin(dateTime.second * 6 * pi / 180);

    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 12, centerFilledBrush);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 16;

    for (double i = 0.0; i < 360.0; i += 12.0) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      var dashBrush = Paint()
        ..color = const Color(0xFFEAECFF)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 1;

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

class HalfCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final center = Offset(centerX, centerY);
    final radius = min(centerX, centerY);

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(centerX / 2, centerY), radius: radius - 10),
      -pi / 2,
      pi,
      false,
      customPaint(),
    );

    // canvas.drawPath(getTrianglePath(size, centerX, centerY), customPaint());
  }

  Path getTrianglePath(Size size, double x, double y) {
    return Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width / 2 + x, y)
      ..lineTo(size.width / 2, y)
      ..lineTo(size.width / 2 - x, y);
  }

  Paint customPaint() {
    Paint paint = Paint();
    paint.color = const Color(0x93af99ee);
    paint.isAntiAlias = true;
    paint.strokeWidth = 10;
    return paint;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
