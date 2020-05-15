import 'package:flutter/material.dart';

class SwipeableWidgetSlide extends StatelessWidget {
  const SwipeableWidgetSlide({
    Key key,
    this.onLeftSwipe,
    this.onRightSwipe,
    this.onTopSwipe,
    this.onBottomSwipe,
    @required this.child,
    this.nextCards = const [],
  }) : super(key: key);

  final Function onLeftSwipe;
  final Function onRightSwipe;
  final Function onTopSwipe;
  final Function onBottomSwipe;

  /// Required, this is the actual card that can be swiped
  final Widget child;
  final List nextCards;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          ...nextCards,
          _topCard(),
        ],
      ),
    );
  }

  Widget _topCard() {
    return Align(
      alignment: Alignment.center,

      // Using a dismissible instead of animations may give better performance
      // especially on lower end devices
      child: Dismissible(
        key: key,
        direction: DismissDirection.vertical,
        onDismissed: (DismissDirection dir) {
          if (dir == DismissDirection.up) onTopSwipe();
          if (dir == DismissDirection.down) onBottomSwipe();
        },

        // nesting another dismissible so we can get vertical and horizontal
        // dismiss directions
        child: Dismissible(
          key: key,
          direction: DismissDirection.horizontal,
          onDismissed: (DismissDirection dir) {
            if (dir == DismissDirection.startToEnd) onRightSwipe();
            if (dir == DismissDirection.endToStart) onLeftSwipe();
          },
          child: Container(
            // By default, the dismissble will disapear when it is beyond it's
            // height or width. Giving it infinite height and width makes sure
            // it goes off screen before disappearing
            height: double.infinity,
            width: double.infinity,
            child: Stack(children: [
              Align(
                alignment: Alignment.center,
                child: child,
              )
            ]),
            // height: 100,
          ),
        ),
      ),
    );
  }
}
