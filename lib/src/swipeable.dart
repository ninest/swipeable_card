import 'package:flutter/material.dart';
import 'package:swipeable_card/src/swipeable_widget_controller.dart';

class SwipeableWidget extends StatefulWidget {
  SwipeableWidget({
    Key key,
    this.swipeableWidgetController,
    this.durationMilliseconds = 120,
    this.sensitivity = 2.0,

    // (putting spacing to make it more clear to me)
    this.enableVerticalSwiping = false,

    //
    this.outsideScreenHorizontalValue,
    this.outsideScreenVerticalValue,

    //
    this.horizontalThreshold = 0.85,
    this.verticalThreshold = 0.90,

    //
    this.onHorizontalSwipe,
    this.onVerticalSwipe,
    @required this.child,
  }) : super(key: key);

  final SwipeableWidgetController swipeableWidgetController;

  /// How long it takes for the swipeable widget to go back to its original
  /// position or be swiped away
  final int durationMilliseconds;

  /// The multiplier for the drag alignment. A value of 2.5 to 3 feels natural
  /// while higher values will be better for larger screens
  final double sensitivity;

  /// Whether to enable swiping cards vertically
  final bool enableVerticalSwiping;

  /// This is pretty much a trial and error value. It's the x value for Align
  /// for the child that signifies a position beyond the screen
  final double outsideScreenHorizontalValue;

  /// The y value for Align for the child that signified a position
  /// beyond the screen
  final double outsideScreenVerticalValue;

  /// Defines an x (horizontal axis) value for alignment. If the widget is dragged
  /// beyond the horizontalThreshold, it will be animated out
  final double horizontalThreshold;

  final double verticalThreshold;

  /// Function called when the widget is swiped then animated beyond
  /// the horizontalThreshold
  final Function onHorizontalSwipe;

  /// Function called when the widget is swiped then animated beyond
  /// the verticalThreshold
  final Function onVerticalSwipe;

  /// The child, that becomes the swipeable widget
  final Widget child;

  @override
  _SwipeableWidgetState createState() => _SwipeableWidgetState();
}

class _SwipeableWidgetState extends State<SwipeableWidget>
    with SingleTickerProviderStateMixin {
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
  void _runLeaveScreenAnimationHorizontal({bool toLeft = false}) {
    // Interpolation out of the screen (either left side or right side)
    _animation = _controller.drive(
      AlignmentTween(
        begin: _alignment,
        end: Alignment(
          // Make it go to the left is specified
          toLeft
              ? -widget.outsideScreenHorizontalValue
              : widget.outsideScreenHorizontalValue,
          // Make it go a little lower to make it look more natural
          _alignment.y + 0.2,
        ),
      ),
    );

    _controller.reset();
    _controller.forward();
  }

  void _runLeaveScreenAnimationVertical({bool toBottom = false}) {
    print('tobottom? $toBottom');
    _animation = _controller.drive(
      AlignmentTween(
        begin: _alignment,
        end: Alignment(
          _alignment.x,
          toBottom
              ? widget.outsideScreenVerticalValue
              : -widget.outsideScreenVerticalValue,
        ),
      ),
    );

    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // controller isn't necessary
    widget.swipeableWidgetController?.setListener((swipeTrigger) {
      switch (swipeTrigger) {
        // swipe trigger can be one of the values of [SwipeableDirection]
        case SwipeableDirection.horizontalLeft:
          _dismissHorizontally(toLeft: true);
          break;

        case SwipeableDirection.horizontalRight:
          _dismissHorizontally(toRight: true);
          break;

        case SwipeableDirection.verticalTop:
          _dismissVertically(toTop: true);
          break;

        case SwipeableDirection.verticalBottom:
          _dismissVertically(toBottom: true);
          break;
      }
    });

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
            details.delta.dx * widget.sensitivity / (size.width / 2),
            details.delta.dy * widget.sensitivity / (size.height / 2),
          );
        });
      },
      onPanEnd: (DragEndDetails details) {
        /*
        There are 2 possibilities:
        1. The card was dragged beyond the horizontalThreshold and should be
        animated out horizontally
        2. The card was dragged beyond the verticalThreshold and should 
        be animated out vertically
        3. The card was not dragged beyond the threshold (should be animated
        back to the origin)
        */

        // (1)
        if (_alignment.x.abs() > widget.horizontalThreshold) {
          // it's swiped to the right side
          _dismissHorizontally();
          // (2)
        } else if (widget.enableVerticalSwiping && //
            _alignment.y.abs() > widget.verticalThreshold) {
          // it's swiped to the top
          _dismissVertically();
        } else {
          // (3) The widget has been left down at the finger at a position, so
          // animate it going back to the origin (center)
          _runBackToOriginAnimation();
          // Note that there is only an animation here, no function is being
          // executed
        }
      },
      child: Align(
        alignment: _alignment,
        child: widget.child,
      ),
    );
  }

  /// [then] is called after the card has moved back to the center
  /// It is the function to execute once a card has been swiped away
  void _cardToOrigin({@required Function then}) {
    /* 
    We need to wait for the animation to finish. Only then we should 
    execute the [onSwipeSide] function.
    That's why the duration of the future.delayed is higher. We need to 
    wait for the animation to complete fully
    */

    Future.delayed(Duration(milliseconds: widget.durationMilliseconds + 150))
        .then((_) {
      // Move the widget (child) back to the center without animation,
      // giving the appearance that the next widget "in line" has come to
      // the top
      // It is expected that the child of this widget is being changed
      // through state management
      setState(() {
        _alignment = Alignment.center;
      });

      // the card has successfully been swiped away, so call the function
      then();
    });
  }

  /// Animate the card swiping away horizontally and execute the function
  /// [onHorizontalSwipe]
  /// Either [toLeft] or [toRight] are only required if the widget is being
  /// animated with the controller (without a swipe)
  /// This is because _alignment.x is available to tell us if we
  void _dismissHorizontally({bool toLeft = false, bool toRight = false}) {
    // below is executed when card is being swiped automatically (with controller)
    if (toLeft)
      _runLeaveScreenAnimationHorizontal(toLeft: true);
    else if (toRight)
      _runLeaveScreenAnimationHorizontal();
    else {
      // below is executed when none (toLeft nor roRight) are provided
      if (_alignment.x > widget.horizontalThreshold) {
        _runLeaveScreenAnimationHorizontal();
      }
      // it's dragged to the left side
      else {
        // so animate it leaving from the left side
        _runLeaveScreenAnimationHorizontal(toLeft: true);
      }
    }

    // this moves the card to the origin with no animation
    _cardToOrigin(then: () => widget.onHorizontalSwipe());
  }

  /// Animate the card swiping away horizontally and execute the function
  /// [onVerticalSwipe]
  /// /// Either [toTop] or [toBottom] are only required if the widget is being
  /// animated with the controller (without a swipe
  void _dismissVertically({bool toTop = false, bool toBottom = false}) {
    // below is executed when card is being swiped automatically (with controller)
    if (toTop)
      _runLeaveScreenAnimationVertical();
    else if (toBottom)
      _runLeaveScreenAnimationVertical(toBottom: true);
    else {
      // below is executed when none (toTop nor toBottom) are provided
      if (_alignment.y < widget.verticalThreshold) {
        _runLeaveScreenAnimationVertical();
      }
      // it's dragged to the bottom
      else {
        _runLeaveScreenAnimationVertical(toBottom: true);
      }
    }
    // this moves the card to the origin with no animation
    _cardToOrigin(then: () => widget.onVerticalSwipe());
  }
}
