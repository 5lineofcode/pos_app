import 'package:flutter/material.dart';

class AnimoView extends StatefulWidget {
  final Widget child;
  final Cubic curve;
  final int duration;

  const AnimoView({
    Key key,
    this.child,
    this.curve,
    this.duration = 1000,
  }) : super(key: key);

  @override
  _AnimoViewState createState() => _AnimoViewState();
}

class _AnimoViewState extends State<AnimoView> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.1, 1.0, curve: widget.curve ?? Curves.fastOutSlowIn),
      ),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: widget.child,
          ),
        );
      },
    );
  }
}
