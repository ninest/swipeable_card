import 'package:flutter/material.dart';
import 'package:swipable_widget/swipable_widget.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    final double screenWidth = size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SwipableWidget(
            outsideScreenSideValue: 5.0,
            width: screenWidth/1.5,
            height: screenHeight/2,
            child: CardExample(
              
              width: screenWidth/1.5,
              height: screenHeight/2,
            ),
          ),
        ],
      ),
    );
  }
}

class CardExample extends StatelessWidget {
  const CardExample({Key key, this.color = Colors.indigo, this.width, this.height})
      : super(key: key);
  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10.0)),
        child: Text("123456789"));
  }
}
