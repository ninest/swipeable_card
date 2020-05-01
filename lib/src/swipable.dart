import 'dart:io';
import 'package:flutter/material.dart';

f() {}

class SwipableWidget extends StatefulWidget {
  SwipableWidget({
    Key key,
    this.durationMilliseconds = 990,
    this.scrollSensitivity = 1.5,
    this.horizontalThreshold = 0.85,
    this.onHorizontalSwipe,
    this.onVerticalSwipe,
    @required this.child,
  }) : super(key: key);

  /// How long it takes for the swipable widget to go back to its original
  /// position or be swiped away
  final int durationMilliseconds;

  /// The multiplier for the drag alignment. A value of 2.5 to 3 feels natural
  /// while higher values will be better for larger screens
  final double scrollSensitivity;

  /// Defines an x (horizontal axis) value for alignment. If the widget is dragged
  /// beyond the [horizontalThreshold], it will be animated out
  final double horizontalThreshold;

  /// Function called when the widget is swiped then animated beyond
  /// the [horizontalThreshold]
  final Function onHorizontalSwipe;

  /// Function called when the widget is swiped then animated beyond
  /// the [verticalThreshold]
  final Function onVerticalSwipe;

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

  // /// Animating the card outside the screen.
  // /// [toLeft] is true when the card is to be animated leaving to the left
  // void _runLeaveScreenAnimation({double screenWidth, bool toLeft = false}) {
  //   // The below values were found through trial and error on an Android device
  //   // and iPhone. These may require additional tweaking
  //   print(screenWidth);
  //   double _sideAlignmentEnd = Platform.isAndroid ? 8.0 : 15.0;

  //   // Interpolation out of the screen (either left side or right side)
  //   _animation = _controller.drive(AlignmentTween(
  //     begin: _alignment,
  //     end: Alignment(
  //         // Make it go to the left is specified
  //         toLeft ? -_sideAlignmentEnd : _sideAlignmentEnd,
  //         // Make it go a little lower to make it look more natural
  //         _alignment.y + 0.2),
  //   ));

  //   _controller.reset();
  //   _controller.forward();
  // }

  bool _left = false;
  void changePositioned(bool value) {
    setState(() {
      _left = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // To get the child widget's width and height
    final size = MediaQuery.of(context).size;

    return AnimatedPositioned(
      duration: Duration(milliseconds: _left ? widget.durationMilliseconds : 0),
      right: 1,
      left: _left ? size.width : 1,
      top: 1,
      bottom: 1,
      child: GestureDetector(
        onPanDown: (_) => _controller.stop(),
        onPanUpdate: (DragUpdateDetails details) {
          // Update the position of the child widget based off the position of the
          // user's finger
          setState(() {
            // TODO
            // use global position with the AnimatedPositioned
            print(details.globalPosition.dx);
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
          1. The card was dragged beyond the horizontalThreshold and should be animated
          out horizontally
          2. The card was dragged beyond the verticalThreshold and should be animated
          out vertically

          3. The card was not dragged beyond the threshold (should be animated
          back to the origin)
          */

          // (1)
          // TODO: use absolute to remove the need of using or
          if (_alignment.x < -widget.horizontalThreshold ||
              _alignment.x > widget.horizontalThreshold) {
            if (_alignment.x > widget.horizontalThreshold) {
              // _runLeaveScreenAnimation(screenWidth: size.width);
              changePositioned(true);
            }
            // If it's dragged to the left side, animate it leaving from the left side
            else {
              // _runLeaveScreenAnimation(screenWidth: size.width, toLeft: true);
            }

            /* 
            We need to wait for the animation to finish. Only then we should execute the
            [onSwipeSide] function.
            That's why the duration of the future.delayed is higher. We need to wait for the
            animation to complete fully
            */

            Future.delayed(Duration(milliseconds: widget.durationMilliseconds + 100)).then((_) {
              // Move the widget (child) back to the center without animation, giving the appearance
              // that the next widget "in line" has come to the top
              // It is expected that the child of this widget is being changed through state management
              changePositioned(false);
              setState(() {
                _alignment = Alignment.center;
              });

              // the card has successfully been swiped away, so call the function
              widget.onHorizontalSwipe();
            });
          } else {
            print("back to origin");
            // (3) The widget has been left down at the finger at a position, so animate
            // it going back to the origin (center)
            _runBackToOriginAnimation();
          }
        },
        child: Align(
          alignment: _alignment,
          child: widget.child,
        ),
      ),
    );

    // return Container(
    //   child: widget.child,
    // );
  }
}
