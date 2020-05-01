import 'package:flutter/material.dart';
import 'package:swipable_widget/swipable_widget.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: SwipableWidget(
              child: CardExample(),
            ),
          )
        ],
      ),
    );
  }
}

class CardExample extends StatelessWidget {
  const CardExample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 200,
      color: Colors.indigo,
      child: Text("This is an example"),
    );
  }
}