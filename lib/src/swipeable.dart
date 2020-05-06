import 'package:flutter/material.dart';

class SwipeableWidget extends StatefulWidget {
  SwipeableWidget({
    Key key,
    this.durationMilliseconds = 120,
    this.sensitivity = 2.0,
    this.horizontalThreshold = 0.85,
    this.outsideScreenHorizontalValue,
    this.onHorizontalSwipe,
    this.onVerticalSwipe,
    // this.height,
    // this.width,
    @required this.child,
  }) : super(key: key);

  /// How long it takes for the swipeable widget to go back to its original
  /// position or be swiped away
  final int durationMilliseconds;

  /// The multiplier for the drag alignment. A value of 2.5 to 3 feels natural
  /// while higher values will be better for larger screens
  final double sensitivity;

  /// This is pretty much a trial and error value. It's the x value for Align
  /// for the child that signifies a position beyond the screen
  final double outsideScreenHorizontalValue;

  /// Defines an x (horizontal axis) value for alignment. If the widget is dragged
  /// beyond the [horizontalThreshold], it will be animated out
  final double horizontalThreshold;

  /// Function called when the widget is swiped then animated beyond
  /// the [horizontalThreshold]
  final Function onHorizontalSwipe;

  /// Function called when the widget is swiped then animated beyond
  /// the [verticalThreshold]
  final Function onVerticalSwipe;

  // final double height, width;

  final Widget child;

  @override
  _SwipeableWidgetState createState() => _SwipeableWidgetState();
}

class _SwipeableWidgetState extends State<SwipeableWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  // Holds the current alignment of the swipeable widget
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

    // Interpolation out of the screen (either left side or right side)
    _animation = _controller.drive(AlignmentTween(
      begin: _alignment,
      end: Alignment(
          // Make it go to the left is specified
          toLeft ? -widget.outsideScreenHorizontalValue : widget.outsideScreenHorizontalValue,
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
    // final double screenHeight = size.height;
    // final double screenWidth = size.width;

    return GestureDetector(
      onPanDown: (_) => _controller.stop(),
      onPanUpdate: (DragUpdateDetails details) {
        // Update the position of the child widget based off the position of the
        // user's finger
        setState(() {
          _alignment += Alignment(
            // Dividing by 2 to convert the distance dragged to the coordinates
            // used by Align
            details.delta.dx * widget.sensitivity / (size.width / 2),
            details.delta.dy * widget.sensitivity / (size.height / 2),
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
        if (_alignment.x < -widget.horizontalThreshold ||
            _alignment.x > widget.horizontalThreshold) {
          if (_alignment.x > widget.horizontalThreshold) {
            _runLeaveScreenAnimation();
          }
          // If it's dragged to the left side, animate it leaving from the left side
          else {
            _runLeaveScreenAnimation(toLeft: true);
          }

          /* 
          We need to wait for the animation to finish. Only then we should execute the
          [onSwipeSide] function.
          That's why the duration of the future.delayed is higher. We need to wait for the
          animation to complete fully
          */

          Future.delayed(Duration(milliseconds: widget.durationMilliseconds + 150)).then((_) {
            // Move the widget (child) back to the center without animation, giving the appearance
            // that the next widget "in line" has come to the top
            // It is expected that the child of this widget is being changed through state management
            setState(() {
              _alignment = Alignment.center;
            });

            // the card has successfully been swiped away, so call the function
            widget.onHorizontalSwipe();
          });
        } else {
          // (3) The widget has been left down at the finger at a position, so animate
          // it going back to the origin (center)
          _runBackToOriginAnimation();
        }
      },
      child: Align(
        alignment: _alignment,
        child: widget.child,
      ),
    );
  }
}
