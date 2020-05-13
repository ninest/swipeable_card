import 'package:flutter/material.dart';

Animation<Alignment> cardDismissAlignmentAnimation(
      AnimationController controller, Alignment startAlign) {
    double x, y;
    // find direction it's being disissed
    if (startAlign.x > 0) {
      x = startAlign.x + 15.0;
      y = startAlign.y + 0.2;
    } else if (startAlign.x < 0) {
      x = startAlign.x - 15.0;
      y = startAlign.y + 0.2;
    }

    return AlignmentTween(
      begin: startAlign,
      end: Alignment(x, y
          // startAlign.x > 0 ? startAlign.x + 15.0 : startAlign.x - 15.0,
          // startAlign.y + 0.2,
          ),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
  }