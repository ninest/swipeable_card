typedef TriggerListener = void Function(Direction dir);

class SwipeableWidgetController {
  late TriggerListener _listener;

  void triggerSwipeLeft() =>
      _listener(Direction.left);

  void triggerSwipeRight() =>
      _listener(Direction.right);

  void triggerSwipeTop() => _listener(Direction.top);

  void triggerBottom() =>
      _listener(Direction.bottom);

  void setListener(listener) => _listener = listener;
}

enum Direction { left, right, top, bottom }
// class SwipeableDirection {
//   static const int horizontalLeft = 0;
//   static const int horizontalRight = 1;

//   static const int verticalTop = 2;
//   static const int verticalBottom = 3;
// }
