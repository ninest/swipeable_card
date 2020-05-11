<!-- omit in toc -->
# Swipeable Card (beta)

> Add a swipeable card widget that can be swiped like a card to your app

[![Pub](https://img.shields.io/pub/v/swipeable_card.svg?style=flat-square)]()
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
![lic](https://img.shields.io/github/license/themindstorm/swipeable_card?style=flat-square)
[![BMAC](https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-orange.svg?style=flat-square)](https://www.buymeacoffee.com/ninest) 


## Contents
- [Examples](#Examples)
- [Documentation](#Documentation)
- [Issues and limitations](#Issues-and-limitations)
- [Other information](#Other-information)

## Examples

### Demo
<img alt="Demo" src="./readme-assets/demo-1.gif" height="500"> <img alt="Demo" src="./readme-assets/demo-2.gif" height="500">

### App examples
Swipeable Widget is used in the following apps:
- [Shots](https://github.com/themindstorm/Shots)
- Add your own

## Documentation

### Installation
Add `swipeable_card` to your `pubspec.yaml`:

```
dependencies:
  flutter:
    sdk: flutter

  # added below
  swipeable_card: <latest version>
```

### Adding to your app

The swipeable widget has to be placed in a `Stack`, for example:

```
Stack(
  children: <Widget>[
    SwipeableWidget(
      // parameters ...
      child: someChildWidget(),
    ),
  ],
)
```

In the above example, replace `someChildWidget()` with the widget that can be swiped (for example, a playing card-like widget).

### Parameters

<details>

<summary>
Click to reveal all parameters
</summary>

#### int `durationMilliseconds`
- The animation duration that dictates
  - How long it takes the widget to move back to the origin
  - How long it takes for the widget to animate off the screen

  Default value: `120`

#### double `sensitivity`
- The multiplier value for the position of the widget as it's being moved by the finger. Higher values make the swiping of the widget seem more responsive. If you aim to support a wide screen device, a higher sensitivity value is recommended so that the user doesn't have to swipe the widget all the way to the side.

  Default value: `2.0`

#### double `horizontalThreshold`
- The position the swipeable widget is moved horizontally for it to be moved away. 

  Once the widget is moved beyong this theshold, the function `onHorizontalSwipe` is called.

  This [diagram in this video](https://youtu.be/g2E7yl3MwMk?t=56) may help you visualize the correct position.

  Default value: `0.85`

#### double `verticalThreshold`
- Not implemented yet.

  The position the swipeable is moved vertically for it to be moved away.

  Once the widget is moved beyong this theshold, the function `onVerticalSwipe` is called.

  This [diagram in this video](https://youtu.be/g2E7yl3MwMk?t=56) may help you visualize the correct position.

  No defaults set for this.

#### double `outsideScreenHorizontalValue`
- The position the swipeable should end. If you want the swipeable widget to animate going off screen, this value should be over `1.0`.

  **Limitation/Issue**: Finding this value requires some trial and error. Please make a PR if you know off a better way to animate the widget off screen.

#### double `outsideScreenVerticalValue`
- No defaults set for this.

  **Limitation/Issue**: Finding this value also requires some trial and error. Please make a PR if you know off a better way to animate the widget off screen.


#### Function `onHorizontalSwipe`
- The function called when the card is moved beyond the `horizontalThreshold` (in terms of Align). If you're making a card game, this is where you would call the function that calls the next card.

#### Function `onVerticalSwipe`
- The function called when the card is moved above or below the vertical `verticalThreshold` (in terms of Align).

#### SwipeableWidgetController `swipeableWidgetController`
- Controller that can swipe the card automatically (without user interaction).

  The following methods exist:
  - `_swipeableWidgetController.triggerHorizontalSwipeLeft()`
  - `_swipeableWidgetController.triggerHorizontalSwipeRight()`
  - `_swipeableWidgetController.triggerVerticalSwipeTop()`
  - `_swipeableWidgetController.triggerVerticalSwipeBottom()`

#### Widget `child` (required)
- The child widget, which will be swipeable.

</details>


### Basic example
```
SwipeableWidget(
  // this value requires some trial and error to find
  // (see limitations in README)
  outsideScreenHorizontalValue: 8.0,

  child: CardExample(text: "This is card"),
  onHorizontalSwipe: () => print("Card swiped!"),
)
```
See the Example for more details.

## Issues and limitations
### `outsideScreenHorizontalValue`
This value should not be required, as it is find through trial and error. We can remove the requirement of this value once we found a way to properly animate a widget going off screen using `Align`.

## Other information
Project start date: 1 May, 2020.

This package was extracted from my app [Shots](https://github.com/themindstorm/Shots). Check it out!