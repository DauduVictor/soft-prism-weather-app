import 'package:flutter/material.dart';

class ThreeLoaders extends StatefulWidget {

  static const String id = 'threeLoaders';
  const ThreeLoaders({Key? key}) : super(key: key);

  @override
  _ThreeLoadersState createState() => _ThreeLoadersState();
}

class _ThreeLoadersState extends State<ThreeLoaders> with TickerProviderStateMixin {

  /// Initializing the controller
  late AnimationController _controller;

  /// Initializing the curve
  late CurvedAnimation _curve;

  /// Initializing the tween
  late Animation _tween;

  /// Initializing the size tween
  late Animation _sizeTween;

  /// Initializing the colors tween
  late Animation _brownColorTween;
  late Animation _blueColorTween;
  late Animation _greenColorTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
      lowerBound: 0,
      upperBound: 1,
    );
    _controller.addListener(() {
      setState(() {});
    });
    _controller.repeat(reverse: true);

    /// Variable the curve for the box animation
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    /// Variable the tween for the box animation
    _tween = Tween(begin: 1.0, end: 250.0).animate(_curve);

    /// Variable the tween for the box animation
    _sizeTween = Tween(begin: 60.0, end: 10.0).animate(_controller);

    /// Variable the tween for the color animation
    _brownColorTween = ColorTween(begin: Colors.brown.shade800, end: Colors.black).animate(_controller);
    _blueColorTween = ColorTween(begin: Colors.blue.shade800, end: Colors.black).animate(_controller);
    _greenColorTween = ColorTween(begin: Colors.green.shade800, end: Colors.black).animate(_controller);

  }

  bool _showAnimation = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: _showAnimation == false ? CustomPaint(
            painter: TriangleShapePainter(color: Colors.black),
            child: Container(
              width: 60,
              height: 60,
            ),
          ) :AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: _sizeTween.value,
                    height: _sizeTween.value,
                    margin: EdgeInsets.only(top: _tween.value),
                    decoration: BoxDecoration(
                      color: _brownColorTween.value,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  CustomPaint(
                    painter: TriangleShapePainter(
                      color: _blueColorTween.value,
                    ),
                    child: Container(
                      width: _sizeTween.value,
                      height: _sizeTween.value,
                      margin: EdgeInsets.only(top: _tween.value),
                    ),
                  ),
                  Container(
                    width: _sizeTween.value,
                    height: _sizeTween.value,
                    margin: EdgeInsets.only(top: _tween.value),
                    decoration: BoxDecoration(
                      color: _greenColorTween.value,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

class TriangleShapePainter extends CustomPainter {

  Color color;

  TriangleShapePainter({
    required this.color
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    ///setting the color property of the paint
    paint.color = color;

    /// drawing the shape[path] on the canvas using [canvas.drawPath] method
    canvas.drawPath(trianglePath(size.width, size.height), paint);
  }

  Path trianglePath(double x, double y){
    return Path()
      ..moveTo(0, y)
      ..lineTo(x/2, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

