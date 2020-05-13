typedef TriggerListener = void Function(Direction dir);

class SwipeableWidgetController {
  TriggerListener _listener;

  void triggerHorizontalSwipeLeft() =>
      _listener(Direction.left);

  void triggerHorizontalSwipeRight() =>
      _listener(Direction.right);

  void triggerVerticalSwipeTop() => _listener(Direction.top);

  void triggerVerticalSwipeBottom() =>
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
