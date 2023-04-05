import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: Center(
        child: Opacity(
          opacity: _animation.value,
          child: Transform.scale(
            scale: _animation.value * 1.5,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey.shade900,
                    blurRadius: 20.0,
                    spreadRadius: 5.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
