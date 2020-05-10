import 'package:flutter/material.dart';
import 'package:swipeable_card/swipeable_card.dart';

import 'card_example.dart';

class ControllerExampleRoute extends StatefulWidget {
  ControllerExampleRoute({Key key}) : super(key: key);

  @override
  _ControllerExampleRouteState createState() => _ControllerExampleRouteState();
}

class _ControllerExampleRouteState extends State<ControllerExampleRoute> {
  final List<CardExample> cards = [
    CardExample(color: Colors.red, text: "Controller First card"),
    CardExample(color: Colors.blue, text: "Second card"),
    CardExample(color: Colors.orange),
    CardExample(color: Colors.indigo),
    CardExample(color: Colors.green, text: "The next card is the last"),
    CardExample(color: Colors.purple, text: "This is the last card"),
  ];
  int currentCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    SwipeableWidgetController _swc = SwipeableWidgetController();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  child: Text("left"),
                  onPressed: () => _swc.triggerHorizontalSwipeLeft(),
                ),
                FlatButton(
                  child: Text("right"),
                  onPressed: () => _swc.triggerHorizontalSwipeRight(),
                ),
                FlatButton(
                  child: Text("top"),
                  onPressed: () => _swc.triggerVerticalSwipeTop(),
                ),
                FlatButton(
                  child: Text("bottom"),
                  onPressed: () => _swc.triggerVerticalSwipeBottom(),
                ),
              ],
            ),
          ),

          // show next card
          // if there are no next cards, show nothing
          if (!(currentCardIndex + 1 >= cards.length))
            Align(
              alignment: Alignment.center,
              child: cards[currentCardIndex + 1],
            ),

          if (currentCardIndex < cards.length)
            SwipeableWidget(
              swipeableWidgetController: _swc,
              // this value requires some trial and error to find
              // (see limitations in README)
              outsideScreenHorizontalValue: 8.0,
              outsideScreenVerticalValue: 8.0,
              enableVerticalSwiping: true,
              child: cards[currentCardIndex],
              // move to next card when top card is swiped away
              onHorizontalSwipe: () => setState(() => currentCardIndex++),
              onVerticalSwipe: () => setState(() => currentCardIndex++),
            )
          else
            // if the deck is complete, add a button to reset deck
            Align(
              alignment: Alignment.center,
              child: FlatButton(
                child: Text("Reset deck"),
                onPressed: () => setState(() => currentCardIndex = 0),
              ),
            ),
        ],
      ),
    );
  }
}
