# Swipeable Widget

## Parameters

### int `animationDuration`
  The animation duration that dictates
  - How long it takes the widget to move back to the origin
  - How long it takes for the widget to animate off the screen

  Default value: `700`

### double `horizontalThreshold`
  The position the swipeable widget is moved horizontally for it to be moved away. Once the widget is moved beyong this theshold, the function `onHorizontalSwipe` is called.

  This [diagram in this video](https://youtu.be/g2E7yl3MwMk?t=56) may help you visualize the correct position.

  Default value: `0.85`

### double `verticalThreshold`
  **Not implemented yet.**

  The position the swipeable is moved vertically for it to be moved away. Once the widget is moved beyong this theshold, the function `onVerticalSwipe` is called.

  This [diagram in this video](https://youtu.be/g2E7yl3MwMk?t=56) may help you visualize the correct position.

  Default value: `0.95`


### Function `onLeftSwipe`
  The function called when the card is moved beyond the left side `horizontalThreshold` (in terms of Align). If you're making a card game, this is where you would call the function that calls the next card.

### Function `onRightSwipe`
  Similar to `onLeftSwipe`

### SwipeableWidgetController `swipeableWidgetController`
  Controller that can swipe the card automatically (without user interaction).

  The following methods exist:
  - `_swipeableWidgetController.triggerSwipeLeft()`
  - `_swipeableWidgetController.triggerSwipeRight()`

  The below two also exist, but are not yet implemented:
  - `_swipeableWidgetController.triggerSwipeTop()`
  - `_swipeableWidgetController.triggerSwipeBottom()`

### double `scrollSensitivity`
  The multiplier value for dragging the cards. A higher value is recommended for larger displays.

### Widget `child` (required)
  The child widget, which will be swipeable.


### List<Widget> `children`
  The widgets behind the `child`. These can be the other cards if it's a card game.
