/*
Trying to implement swipeable widget using the Positioned widget.

This did not work out, but I'll still leave the file here in case it is of any
help to anyone.
*/

import 'package:flutter/material.dart';

class SwipeableWidget extends StatefulWidget {
  SwipeableWidget({Key key, this.child, this.width, this.height}) : super(key: key);
  final double width;
  final double height;
  final Widget child;

  @override
  _SwipeableWidgetState createState() => _SwipeableWidgetState();
}

class _SwipeableWidgetState extends State<SwipeableWidget> {
  double _top;
  double _left;

  // save last known finger position
  double _fingerY;
  double _fingerX;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      top: _top ?? (screenHeight - widget.height) / 2,
      left: _left ?? (screenWidth - widget.width) / 2,
      child: GestureDetector(
        onPanUpdate: (details) {
          // find exact finger position
          _fingerY = details.globalPosition.dy;
          _fingerX = details.globalPosition.dx;

          // multipliers for swipe sensitivity
          double ys = details.delta.dy;
          double xs = details.delta.dx;

          print(ys);

          // get quadrant
          if (_fingerY > screenWidth / 2) {}

          // set center of widget to finger position
          // double y = _fingerY  * 1.5 - widget.height / 2 ;
          // double x = _fingerX - widget.width / 2;

          setState(() {
            // _top = y;
            // _left = x;
            _top = _top ?? ((screenHeight - widget.height) / 2) + ys * 2;
          });
        },
        onPanEnd: (details) {
          print("Pan end");
          // using last known finger position
          if (_fingerX > screenWidth - 100) {
            print("Animating off screen");
            // animate it off to the right
            print(screenWidth);
            _left = 400;
          } else {
            print("Animate back to center");
            // animate it back to center
            setState(() {
              _top = _left = null;
            });
          }
        },
        child: widget.child,
      ),
    );
  }
}
