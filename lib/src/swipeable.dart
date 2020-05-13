import 'package:flutter/material.dart';
import 'animations.dart';
import 'swipeable_widget_controller.dart';

class SwipeableWidget extends StatefulWidget {
  SwipeableWidget({
    Key key,
    this.cardController,
    this.animationDuration = 700,
    this.horizontalThreshold = 0.85,
    this.verticalThreshold = 0.95,
    this.onLeftSwipe,
    this.onRightSwipe,
    @required this.child,
    this.nextCards,
  }) : super(key: key);

  final SwipeableWidgetController cardController;

  /// Animation duration in millseconds
  final int animationDuration;

  /// Alignment.x value beyond which card will be dismissed
  final double horizontalThreshold;

  /// NOT IMPLEMENTED YET
  final double verticalThreshold;

  /// Function executed when the card is swiped lieft
  final Function onLeftSwipe;

  /// Function executed when the card is swiped lieft
  final Function onRightSwipe;

  /// The child widget, which is swipeable
  final Widget child;

  /// Any widgets to show behind the [child]. These will most likely be the next
  /// few cards in the deck
  final List<Widget> nextCards;

  @override
  _SwipeableWidgetState createState() => _SwipeableWidgetState();
}

class _SwipeableWidgetState extends State<SwipeableWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Alignment _childAlign;
  Alignment _initialAlignment = Alignment.center;

  // stores the direction in which the card is being dismissed
  Direction _dir;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: Duration(milliseconds: widget.animationDuration), vsync: this);
    _controller.addListener(() => setState(() {}));

    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        // when animated completed, put card back at origin
        _childAlign = _initialAlignment;
      }
    });

    // card alignment
    _childAlign = _initialAlignment;
  }

  @override
  Widget build(BuildContext context) {
    // controller isn't necessary
    widget.cardController?.setListener((dir) {
      // animate card out in specified direction
      animateCardLeaving(dir);
    });
    return Expanded(
      child: Stack(
        children: <Widget>[
          ...widget.nextCards,
          child(),
          _controller.status != AnimationStatus.forward
              ? SizedBox.expand(
                  child: GestureDetector(
                    onPanUpdate: (DragUpdateDetails details) {
                      final screenWidth = MediaQuery.of(context).size.width;
                      final screenHeight = MediaQuery.of(context).size.height;
                      setState(() {
                        _childAlign = Alignment(
                          _childAlign.x + 8 * details.delta.dx / screenWidth,
                          _childAlign.y + 10 * details.delta.dy / screenHeight,
                        );
                      });
                    },
                    onPanEnd: (_) {
                      if (_childAlign.x > widget.horizontalThreshold)
                        animateCardLeaving(Direction.right);
                      else if (_childAlign.x < -widget.horizontalThreshold)
                        animateCardLeaving(Direction.left);
                      else {
                        animateCardLeaving(null);
                        // setState(() {
                        //   _childAlign = widget.initialAlignment;
                        // });
                      }
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void animateCardLeaving(Direction dir) {
    Function then;
    switch (dir) {
      case (Direction.left):
        then = widget.onLeftSwipe;
        break;
      case (Direction.right):
        then = widget.onRightSwipe;
        break;
      default:
        // should go to top or bottom
        then = () {};
        break;
    }
    // setting direction in which card is animating too
    _dir = dir;
    _controller.stop();
    _controller.value = 0.0;
    _controller.forward().then((value) => then());
  }

  Widget child() {
    Alignment alignment;

    if (_controller.status == AnimationStatus.forward) {
      alignment = cardDismissAlignmentAnimation(_controller, _childAlign, _dir).value;
    } else {
      alignment = _childAlign;
    }

    return Align(
      alignment: alignment,
      child: widget.child,
    );
  }
}
