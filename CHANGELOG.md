## [1.0.1]- May 13, 2020
- Fixed issue where card would stick to side of screen

## [1.0.0]- May 13, 2020
- Made card movement more smooth in general
- Using curves for animation
- Removed need for:
  - `outsideScreenHorizontalValue`
  - `outsideScreenVerticalValue`
- Split on horizontal swipe to on left and right swipe functions
- Changed function names for `SwipeableWidgetController` (shortened)

## [0.0.2] - May 12, 2020
- Improved [example](https://github.com/ninest/swipeable_card/tree/master/example)
- Improved description of package
- Formatted package files

## [0.0.1] - May 10, 2020
- Added `SwipeableWidget`
  - Can be swiped horizontally then execute a function
  - Can be swiped vertically then execute a function
- Added `SwipeableWidgetController` to automatically swipe cards:
  - `_swipeableWidgetController.triggerHorizontalSwipeLeft()`
  - `_swipeableWidgetController.triggerHorizontalSwipeRight()`
  - `_swipeableWidgetController.triggerVerticalSwipeTop()`
  - `_swipeableWidgetController.triggerVerticalSwipeBottom()`
- Added fully featured example (see `examples/` folder)
