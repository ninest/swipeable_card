// check out https://swipeable-card.now.sh/examples/basic/ for a full
// better explanation

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'example_route.dart';
import 'example_slide_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // make it a full screen app
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        // make the background color darker to put the cards in focus!
        scaffoldBackgroundColor: Color(0xFF111111),
      ),
      // home: ExampleRoute(),
      // home: ExampleRoute(),
      home: ExampleRouteSlide(),
    );
  }
}
