typedef TriggerListener = void Function(int swipeTrigger);

class SwipeableWidgetController {
  TriggerListener _listener;

  void triggerHorizontalSwipeLeft() =>
      _listener(SwipeableDirection.horizontalLeft);

  void triggerHorizontalSwipeRight() =>
      _listener(SwipeableDirection.horizontalRight);

  void triggerVerticalSwipeTop() => _listener(SwipeableDirection.verticalTop);

  void triggerVerticalSwipeBottom() =>
      _listener(SwipeableDirection.verticalBottom);

  void setListener(listener) => _listener = listener;
}

class SwipeableDirection {
  static const int horizontalLeft = 0;
  static const int horizontalRight = 1;

  static const int verticalTop = 2;
  static const int verticalBottom = 3;
}
