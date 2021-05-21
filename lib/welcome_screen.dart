import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'utils/delayed_animation.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 250;
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AvatarGlow(
                  endRadius: 170,
                  duration: Duration(milliseconds: 900),
                  glowColor: Colors.white24,
                  repeat: true,
                  repeatPauseDuration: Duration(milliseconds: 300),
                  startDelay: Duration(milliseconds: 200),
                  child: CircularProfileAvatar(
                    null,
                    child: Image(
                      image: AssetImage(
                        'images/car.jpg',
                      ),
                    ),
                    borderColor: Colors.grey,
                    elevation: 10,
                    radius: 90,
                  ),
                ),
                DelayedAnimation(
                  child: Text(
                    "Welcome to",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        color: color),
                  ),
                  delay: delayedAmount + 1000,
                ),
                SizedBox(
                  height: 10,
                ),
                DelayedAnimation(
                  child: Text(
                    "Smart Car Parking",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 37.0,
                        color: color),
                  ),
                  delay: delayedAmount + 2000,
                ),
                SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  height: 100.0,
                ),
                DelayedAnimation(
                  child: GestureDetector(
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    child: Transform.scale(
                      scale: _scale,
                      child: _animatedButtonUI,
                    ),
                  ),
                  delay: delayedAmount + 4000,
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          )
          ),
    );
  }

  Widget get _animatedButtonUI => GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/home');
        },
        child: Container(
          height: 60,
          width: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              'Next',
              style: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlueAccent
              ),
            ),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
