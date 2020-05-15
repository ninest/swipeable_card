# Quick start

## Installation

Add `swipeable_card` to your `pubspec.yaml`:

```
dependencies:
  flutter:
    sdk: flutter

  # added below
  swipeable_card: <latest version>
```

## Basic example

Basic example
```
SwipeableWidget(

  child: CardExample(text: "This is card"),
  nextCards: [
    CardExample(text: "This is the card"),
    CardExample(text: "This is third card"),
  ]
  onLeftSwipe: () => print("Card swiped!"),
  onRightSwipe: () => print("Card swiped!"),
)
```
See the [Example](/examples/basic) for more details. It contains a detailed write up on how to use the swipeable widget controller too.