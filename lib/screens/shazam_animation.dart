import 'package:flutter/material.dart';

class Shazam extends StatefulWidget {

  static const String id = 'shazam';
  const Shazam({Key? key}) : super(key: key);

  @override
  _ShazamState createState() => _ShazamState();
}

class _ShazamState extends State<Shazam> with TickerProviderStateMixin {

  /// A variable to hold the animation
  late AnimationController _controller;

  /// A variable to hold the bolder circle
  late AnimationController _circleController;

 /// A variable to hold the bolder circle outer
  late AnimationController _circleControllerOuter;

  /// A variable to hold the box shadow tween
  Animation? _shadowTweenAnimation;

  /// A variable to hold the box width tween
  Animation? _widthTweenAnimation;

  /// A variable to hold the box color tween
  late Animation _colorTweenAnimation;

  /// A variable to hold the most outer box width tween
  Animation? _widthMTweenAnimation;

  /// A variable to hold the most outer box color tween
  late Animation _colorMTweenAnimation;

  /// A variable to hold the curve type used in the animation
  late CurvedAnimation _curve;

  /// A variable to hold the curve type used in the box animation
  late CurvedAnimation _boxCurve;

  // A variable to hold the curve type used in the most outer box animation
  late CurvedAnimation _oCurve;

  /// A variable to hold the curve type used in the most outer box animation
  late CurvedAnimation _mCurve;

  /// Variable to hold the tween value of the animation
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    /// Initializing animation for inner box
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    /// Initializing animation for the box
    _circleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    /// Initializing animation for the most outer box
    _circleControllerOuter = AnimationController(
      lowerBound: 0.2,
      upperBound: 0.8,
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _controller.repeat(
      reverse: true,
      period: const Duration(milliseconds: 1200),
    );

    _circleController.repeat(
      period: const Duration(milliseconds: 1600),
    );

    _circleControllerOuter.repeat(
      period: const Duration(milliseconds: 1600),
    );

    /// Variable to hold the outer box animation curve
    _oCurve = CurvedAnimation(parent: _circleController, curve: Curves.bounceInOut);

    /// Variable to hold color tween for the color outer box
    _colorTweenAnimation = ColorTween(begin: Colors.blueGrey.withOpacity(0.7), end: Colors.transparent).animate(_circleController);

    /// Variable to hold the most outer box animation curve
    _mCurve = CurvedAnimation(parent: _circleControllerOuter, curve: Curves.bounceInOut);

    /// Variable to hold color tween for the color most outer box
    _colorMTweenAnimation = ColorTween(begin: Colors.blueGrey.withOpacity(0.7), end: Colors.transparent).animate(_circleControllerOuter);

    /// Variable to hold the tween value for the inner box
    _elevationAnimation = Tween(begin: 1.0, end: 25.0).animate(_controller);

    /// Variable to hold the tween value for the width outer box
    _widthTweenAnimation = Tween(begin: 7.0, end: 0.2).animate(_circleController);

    /// Variable to hold the tween value for the width most outer box
    _widthMTweenAnimation = Tween(begin: 7.0, end: 0.2).animate(_circleControllerOuter);

    /// Variable to hold the animation curve
    _curve = CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    /// Variable to hold the box animation curve
    _boxCurve = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    /// Variable to animate between the given tween sequences
    _shadowTweenAnimation = TweenSequence(
        <TweenSequenceItem<double>> [
          TweenSequenceItem<double>(
            tween: Tween<double>(begin: 0, end: 8),
            weight: 20,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(begin: 8, end: 15),
            weight: 20,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(begin: 15, end: 23),
            weight: 20,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(begin: 23, end: 40),
            weight: 20,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(begin: 40, end: 55),
            weight: 20,
          ),
        ]
    ).animate(_curve);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _circleController.dispose();
    _circleControllerOuter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 117.0),
              child: Center(
                child: Stack(
                  children: [
                    /// Most outer box
                    Center(
                      child: Transform.scale(
                        scale: 1.7 + _mCurve.value,
                        child: Container(
                          height: 350.0 + (_circleControllerOuter.value * 20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            border: Border.all(
                              color: _colorMTweenAnimation.value,
                              width: _widthMTweenAnimation!.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                    /// Outer box
                    Center(
                      child: Transform.scale(
                        scale: 1.7 + _oCurve.value,
                        child: Container(
                          height: 300.0 + (_circleController.value * 20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            border: Border.all(
                              color: _colorTweenAnimation.value,
                              width: _widthTweenAnimation!.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Card(
                        color: Colors.transparent,
                        elevation: _elevationAnimation.value,
                        shadowColor: Colors.blueGrey.withOpacity(0.15),
                        shape: const CircleBorder(),
                        child: Container(
                          padding: EdgeInsets.all(45 + _boxCurve.value * 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              for(double i = 0.85; i < 3.5; i++)
                                BoxShadow(
                                  color: Colors.blueGrey.withOpacity(0.22),
                                  spreadRadius: _shadowTweenAnimation!.value * i,
                                ),
                            ]
                          ),
                          child: Text(
                            'S',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 200 + _boxCurve.value * 15 ,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Center(
                          child: Text(
                            'Listening for music',
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          'Make sure your device can hear the music clearly',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white.withOpacity(0.65),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
