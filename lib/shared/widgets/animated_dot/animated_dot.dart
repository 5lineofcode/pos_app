import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedDot extends StatefulWidget {
  @override
  _AnimatedDotState createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<AnimatedDot> {
  Color color = Colors.red;

  Timer timer;
  void runTimer() {
    timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (color == Colors.red) {
        color = Colors.transparent;
      } else {
        color = Colors.red;
      }
      if (this.mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    runTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 800),
      width: 10.0,
      height: 10.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(
            12.0,
          ),
        ),
      ),
    );
  }
}
