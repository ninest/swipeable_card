import 'dart:io';
import 'package:flutter/material.dart';

class SwipableWidget extends StatefulWidget {
  SwipableWidget({
    Key key,
    this.durationMilliseconds = 120,
    this.scrollSensitivity = 3,
    this.sideThreshold = 0.95,
    @required this.child,
  }) : super(key: key);

  /// How long it takes for the swipable widget to go back to its original
  /// position or be swiped away
  final int durationMilliseconds;

  /// The multiplier for the drag alignment. A value of 2.5 to 3 feels natural
  /// while higher values will be better for larger screens
  final int scrollSensitivity;

  /// Defines an x (horizontal axis) value for alignment. If the widget is dragged
  /// beyond the [sideThreshold], it will be animated out
  final double sideThreshold;

  final Widget child;

  @override
  _SwipableWidgetState createState() => _SwipableWidgetState();
}

class _SwipableWidgetState extends State<SwipableWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  // Holds the current alignment of the swipable widget
  // The widget is in the center by default
  Alignment _alignment = Alignment.center;

  Animation<Alignment> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.durationMilliseconds),
    );

    _controller.addListener(() {
      setState(() {
        _alignment = _animation.value;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Animating the card back to the origin (which is the center)
  void _runBackToOriginAnimation() {
    // Interpolation from position to original position
    _animation = _controller.drive(AlignmentTween(
      begin: _alignment,
      end: Alignment.center,
    ));
    _controller.reset();
    _controller.forward();
  }

  /// Animating the card outside the screen.
  /// [toLeft] is true when the card is to be animated leaving to the left
  void _runLeaveScreenAnimation({bool toLeft = false}) {
    // The below values were found through trial and error on an Android device
    // and iPhone. These may require additional tweaking
    double _sideAlignmentEnd = Platform.isAndroid ? 8.0 : 15.0;

    // Interpolation out of the screen (either left side or right side)
    _animation = _controller.drive(AlignmentTween(
      begin: _alignment,
      end: Alignment(
          // Make it go to the left is specified
          toLeft ? -_sideAlignmentEnd : _sideAlignmentEnd,
          // Make it go a little lower to make it look more natural
          _alignment.y + 0.2),
    ));

    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // To get the child widget's width and height
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onPanDown: (_) => _controller.stop(),
      onPanUpdate: (DragUpdateDetails details) {
        // Update the position of the child widget based off the position of the
        // user's finger
        setState(() {
          _alignment += Alignment(
            // Dividing by 2 to convert the distance dragged to the coordinates
            // used by Align
            details.delta.dx * widget.scrollSensitivity / (size.width / 2),
            details.delta.dy * widget.scrollSensitivity / (size.height / 2),
          );
        });
      },
      onPanEnd: (DragEndDetails details) {
        /*
        There are 2 possibilities:
        1. The card was dragged beyond the sideThreshold and should be animated
        out
        2. The card was not dragged beyond the threshold (should be animated
        back to the origin)
        */
        if (_alignment.x < -widget.sideThreshold || _alignment.x > widget.sideThreshold) {
          if (_alignment.x > widget.sideThreshold) _runLeaveScreenAnimation();
          // If it's dragged to the left side, animate it leaving from the left side
          else _runLeaveScreenAnimation(toLeft: true);

          /* 
          We need to wait for the animation to finish. Only then we should execute the
          [onSwipeSide] function
          */
        }
      },
      child: widget.child,
    );

    // return Container(
    //   child: widget.child,
    // );
  }
}
