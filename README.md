<!-- omit in toc -->
# Swipable Widget (beta)

> Add swipable widget that can be swiped like a card to your app

- [Quick start guide](#quick-start-guide)
  - [Installation](#installation)
- [Examples](#examples)
  - [App examples](#app-examples)
- [Documentation](#documentation)
  - [parameters](#parameters)
    - [int `durationMilliseconds`](#int-durationmilliseconds)
    - [double `sensitivity`](#double-sensitivity)
    - [double `horizontalThreshold`](#double-horizontalthreshold)
    - [double `verticalThreshold`](#double-verticalthreshold)
    - [double `outsideScreenHorizontalValue`](#double-outsidescreenhorizontalvalue)
    - [double `outsideScreenVerticalValue`](#double-outsidescreenverticalvalue)
    - [Function `onHorizontalSwipe`](#function-onhorizontalswipe)
    - [Function`onVerticalSwipe`](#functiononverticalswipe)
    - [Widget `child` (required)](#widget-child-required)
- [Issues and limitation](#issues-and-limitation)

## Quick start guide

### Installation
Add `swipable_widget` to your `pubspec.yaml`:

```
dependencies:
  flutter:
    sdk: flutter

  # added below
  swipable_widget:
```

## Examples

### App examples
Swipable Widget is used in the following apps:
- [Shots](https://github.com/themindstorm/Shots)
- Add your own

## Documentation
The swipable widget has to be placed in a `Stack`, for example:

```
Stack(
  children: <Widget>[
    SwipableWidget(
      // parameters ...
      child: someChildWidget(),
    ),
  ],
)
```

### parameters
#### int `durationMilliseconds`
The animation duration that dictates
- How long it takes the widget to move back to the origin
- How long it takes for the widget to animate off the screen

Default value: 120

#### double `sensitivity`
The multiplier value for the position of the widget as it's being moved by the finger. Higher values make the swiping of the widget seem more responsive. If you aim to support a wide screen device, a higher sensitivity value is recommended so that the user doesn't have to swipe the widget all the way to the side.

Default value: 2.0

#### double `horizontalThreshold`
The position the swipable widget is moved horizontally for it to be moved away. 

This [diagram in this video](https://youtu.be/g2E7yl3MwMk?t=56) may help you visualize the correct position.

Default value: 0.85

#### double `verticalThreshold`
Not implemented yet.

#### double `outsideScreenHorizontalValue`
The position the swipable should end. If you want the swipable widget to animate going off screen, this value should be over `1.0`.

**Limitation/Issue**: Finding this value requires some trial and error. Please make a PR if you know off a better way to animate the widget off screen.

#### double `outsideScreenVerticalValue`
Not implemented yet.

#### Function `onHorizontalSwipe`
The function called when the card is moved to either side. If you're making a card game, this is where you would call the function that calls the next card.

#### Function`onVerticalSwipe`
Not implemented yet.

#### Widget `child` (required)
The child widget, which will be swipable.

## Issues and limitation


