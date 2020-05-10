import 'package:flutter/material.dart';
import 'package:swipeable_card/swipeable_card.dart';

import 'card_example.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
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
    print(currentCardIndex);
    print(cards.length);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // show next card
          // if there are no next cards, show nothing
          if (!(currentCardIndex + 1 >= cards.length))
            Align(
              alignment: Alignment.center,
              child: cards[currentCardIndex + 1],
            ),

          if (currentCardIndex < cards.length)
            SwipeableWidget(
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
