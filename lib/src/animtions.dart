import 'package:flutter/material.dart';
import 'package:swipeable_card/src/swipeable_widget_controller.dart';

Animation<Alignment> cardDismissAlignmentAnimation(
    AnimationController controller, Alignment startAlign, Direction dir) {
  double x, y;
  // find direction it's being disissed
  if (dir == Direction.right || startAlign.x > 0) {
    print("RIGHT, $dir");
    x = startAlign.x + 15.0;
    y = startAlign.y + 0.2;
  } else if (dir == Direction.left || startAlign.x < 0) {
    print("LEFT, $dir");
    x = startAlign.x - 15.0;
    y = startAlign.y + 0.2;
  } else {
    // TODO: implement top and bottom
    x = startAlign.x + 15.0;
    y = startAlign.y + 0.2;
  }

  return AlignmentTween(
    begin: startAlign,
    end: Alignment(x, y),
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 0.5, curve: Curves.easeIn),
    ),
  );
}
