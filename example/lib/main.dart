import 'package:flutter/material.dart';
import 'package:swipable_widget/swipable_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: SwipableWidget(),
        ),
      ),
    );
  }
}
