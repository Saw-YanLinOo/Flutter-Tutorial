import 'package:flutter/material.dart';

class DemoCustomPinter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 2.0
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    // canvas.drawRect(
    //     Rect.fromCircle(
    //         center: Offset(size.width / 2, size.height / 2), radius: 88),
    //     paint);
    // var circlePaint = Paint()
    //   ..strokeWidth = 2.0
    //   ..color = Colors.white
    //   ..style = PaintingStyle.fill;
    // canvas.drawCircle(Offset(size.width / 2, size.height / 2), 88, circlePaint);

    canvas.drawLine(Offset(0, 200), Offset(100, 0), paint);
    canvas.drawLine(Offset(100, 0), Offset(300, 0), paint);
    canvas.drawLine(Offset(300, 0), Offset(300, 200), paint);
    canvas.drawLine(Offset(300, 200), Offset(0, 200), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CustomPinterDemo extends StatelessWidget {
  const CustomPinterDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CustomPaint(
          size: const Size(300, 300),
          painter: DemoCustomPinter(),
        ),
      ),
    );
  }
}
