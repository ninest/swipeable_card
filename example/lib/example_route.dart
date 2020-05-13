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
    return Scaffold(
      body: Column(
        children: <Widget>[
          SwipeableWidget(
            animationDuration: 700,
            child: cards[currentCardIndex],
            nextCards: <Widget>[
              Align(
                alignment: Alignment.center,
                child: cards[currentCardIndex + 1],
              ),
            ],
          ),
        ],
      ),
      // body: Stack(
      //   children: <Widget>[
      //     // show next card
      //     // if there are no next cards, show nothing
      //     if (!(currentCardIndex + 1 >= cards.length))
      //       Align(
      //         alignment: Alignment.center,
      //         child: cards[currentCardIndex + 1],
      //       ),

      //     if (currentCardIndex < cards.length)
      //       SwipeableWidget(
      //         child: cards[currentCardIndex],
      //       )
      //     else
      //       // if the deck is complete, add a button to reset deck
      //       Align(
      //         alignment: Alignment.center,
      //         child: FlatButton(
      //           child: Text("Reset deck"),
      //           onPressed: () => setState(() => currentCardIndex = 0),
      //         ),
      //       ),
      //   ],
      // ),
    );
  }
}
