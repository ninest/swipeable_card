import 'package:flutter/material.dart';

class SwipeableWidget extends StatefulWidget {
  SwipeableWidget({
    Key key,
    this.animationDuration = 700,
    this.horizontalThreshold = 3.0,
    this.onHorizontalSwipe,
    this.initialAlignment = Alignment.center,
    @required this.child,
    this.nextCards,
  }) : super(key: key);

  final int animationDuration;

  final double horizontalThreshold;

  final Function onHorizontalSwipe;

  final Alignment initialAlignment;

  /// The child widget, which is swipeable
  final Widget child;

  final List<Widget> nextCards;

  @override
  _SwipeableWidgetState createState() => _SwipeableWidgetState();
}

class _SwipeableWidgetState extends State<SwipeableWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Alignment _childAlign;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: Duration(milliseconds: widget.animationDuration), vsync: this);
    _controller.addListener(() => setState(() {}));

    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        print("status completed");
        print(_childAlign);
        setState(() {
          _childAlign = Alignment.center;
        });
        widget.onHorizontalSwipe();
      }
    });

    // card alignment
    _childAlign = widget.initialAlignment;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          ...widget.nextCards,
          child(),
          _controller.status != AnimationStatus.forward
              ? SizedBox.expand(
                  child: Container(
                    // color: Colors.green,
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
                        if (_childAlign.x > widget.horizontalThreshold ||
                            _childAlign.x < -widget.horizontalThreshold) {
                          animateCard();
                        } else {
                          setState(() {
                            _childAlign = widget.initialAlignment;
                          });
                        }
                      },
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void animateCard() {
    _controller.stop();
    _controller.value = 0.0;
    _controller.forward();
  }

  Animation<Alignment> cardDismissAlignmentAnimation(
          AnimationController controller, Alignment startAlign) =>
      AlignmentTween(
        begin: startAlign,
        end: Alignment(
          startAlign.x > 0 ? startAlign.x + 15.0 : startAlign.x - 15.0,
          startAlign.y + 0.2,
        ),
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(
            0.0,
            0.5,
            curve: Curves.easeIn,
          ),
        ),
      );

  Widget child() => Align(
        alignment: _controller.status == AnimationStatus.forward //
            ? cardDismissAlignmentAnimation(_controller, _childAlign).value
            : _childAlign,
        // alignment: _childAlign,
        child: widget.child,
      );
}
