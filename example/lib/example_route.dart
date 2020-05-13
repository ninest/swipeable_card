import 'package:flutter/material.dart';
import 'package:swipeable_card/swipeable_card.dart';

import 'card_example.dart';

class ExampleRoute extends StatefulWidget {
  const ExampleRoute({Key key}) : super(key: key);

  @override
  _ExampleRouteState createState() => _ExampleRouteState();
}

class _ExampleRouteState extends State<ExampleRoute> {
  final List<CardExample> cards = [
    CardExample(color: Colors.red, text: "First card"),
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
        body: SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          if (currentCardIndex < cards.length)
            SwipeableWidget(
              cardController: _swc,
              animationDuration: 700,
              horizontalThreshold: 0.85,
              initialAlignment: Alignment.center,
              child: cards[currentCardIndex],
              nextCards: <Widget>[
                // show next card
                // if there are no next cards, show nothing
                if (!(currentCardIndex + 1 >= cards.length))
                  Align(
                    alignment: Alignment.center,
                    child: cards[currentCardIndex + 1],
                  ),
              ],
              onLeftSwipe: () {
                print("left");
                setState(() {
                  currentCardIndex++;
                });
              },
              onRightSwipe: () {
                print("right");
                setState(() {
                  currentCardIndex++;
                });
              },
            )
          else
            // if the deck is complete, add a button to reset deck
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 100.0),
                child: FlatButton(
                  child: Text("Reset deck"),
                  onPressed: () => setState(() => currentCardIndex = 0),
                ),
              ),
            ),
          RaisedButton(
            child: Text("Left"),
            onPressed: () => _swc.triggerHorizontalSwipeLeft(),
          ),
          RaisedButton(
            child: Text("Right"),
            onPressed: () => _swc.triggerHorizontalSwipeRight(),
          ),
        ],
      ),
    ));
  }
}
