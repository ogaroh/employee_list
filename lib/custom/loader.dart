import 'dart:math';

import 'package:flutter/material.dart';

class CustomLoader extends StatefulWidget {
  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animationRotation;
  Animation<double> animationRadiusIn;
  Animation<double> animationRadiusOut;

  final double initialRadius = 15.0;

  double radius = 0.0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    animationRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
      ),
    );

    animationRadiusIn = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.75,
          1.0,
          curve: Curves.elasticIn,
        ),
      ),
    );

    animationRadiusOut = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.25,
          curve: Curves.elasticOut,
        ),
      ),
    );

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          radius = animationRadiusIn.value * initialRadius;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          radius = animationRadiusOut.value * initialRadius;
        }
      });
    });

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        child: Center(
          child: RotationTransition(
            turns: animationRotation,
            child: Stack(
              children: [
                Dot(
                  radius: 15.0,
                  color: Colors.black12,
                ),
                Transform.translate(
                  offset: Offset(
                    initialRadius * cos(pi / 4),
                    initialRadius * sin(pi / 4),
                  ),
                  child: Dot(radius: 5.0, color: Colors.red),
                ),
                Transform.translate(
                  offset: Offset(
                    initialRadius * cos(2 * pi / 4),
                    initialRadius * sin(2 * pi / 4),
                  ),
                  child: Dot(radius: 5.0, color: Colors.blue),
                ),
                Transform.translate(
                  offset: Offset(
                    initialRadius * cos(3 * pi / 4),
                    initialRadius * sin(3 * pi / 4),
                  ),
                  child: Dot(radius: 5.0, color: Colors.pink),
                ),
                Transform.translate(
                  offset: Offset(
                    initialRadius * cos(4 * pi / 4),
                    initialRadius * sin(4 * pi / 4),
                  ),
                  child: Dot(radius: 5.0, color: Colors.green),
                ),
                Transform.translate(
                  offset: Offset(
                    initialRadius * cos(5 * pi / 4),
                    initialRadius * sin(5 * pi / 4),
                  ),
                  child: Dot(radius: 5.0, color: Colors.purple),
                ),
                Transform.translate(
                  offset: Offset(
                    initialRadius * cos(6 * pi / 4),
                    initialRadius * sin(6 * pi / 4),
                  ),
                  child: Dot(radius: 5.0, color: Colors.orange),
                ),
                Transform.translate(
                  offset: Offset(
                    initialRadius * cos(7 * pi / 4),
                    initialRadius * sin(7 * pi / 4),
                  ),
                  child: Dot(radius: 5.0, color: Colors.redAccent),
                ),
                Transform.translate(
                  offset: Offset(
                    initialRadius * cos(8 * pi / 4),
                    initialRadius * sin(8 * pi / 4),
                  ),
                  child: Dot(radius: 5.0, color: Colors.teal),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  const Dot({Key key, this.radius, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: this.radius,
        width: this.radius,
        decoration: BoxDecoration(
          color: this.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
