<!-- omit in toc -->
# Swipeable Widget (beta)

> Add swipeable widget that can be swiped like a card to your app

[![Pub](https://img.shields.io/pub/v/swipeable_widget.svg?style=flat-square)]()
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
![lic](https://img.shields.io/github/license/themindstorm/swipeable_widget?style=flat-square)
[![BMAC](https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-orange.svg?style=flat-square)](https://www.buymeacoffee.com/themindstorm) 


## Contents

<details>
<summary>
Click to reveal the table of contents
</summary>

- [Contents](#contents)
- [Examples](#examples)
  - [Demo](#demo)
  - [App examples](#app-examples)
- [Documentation](#documentation)
  - [Installation](#installation)
  - [Adding to your app](#adding-to-your-app)
  - [Parameters](#parameters)
    - [int `durationMilliseconds`](#int-durationmilliseconds)
    - [double `sensitivity`](#double-sensitivity)
    - [double `horizontalThreshold`](#double-horizontalthreshold)
    - [double `verticalThreshold`](#double-verticalthreshold)
    - [double `outsideScreenHorizontalValue`](#double-outsidescreenhorizontalvalue)
    - [double `outsideScreenVerticalValue`](#double-outsidescreenverticalvalue)
    - [Function `onHorizontalSwipe`](#function-onhorizontalswipe)
    - [Function`onVerticalSwipe`](#functiononverticalswipe)
    - [Widget `child` (required)](#widget-child-required)
  - [Basic example](#basic-example)
- [Issues and limitation](#issues-and-limitation)
  - [`outsideScreenHorizontalValue`](#outsidescreenhorizontalvalue)
- [Other information](#other-information)

</details>

## Examples

### Demo
<img alt="Demo" src="./readme-assets/demo.gif" height="500">

### App examples
Swipeable Widget is used in the following apps:
- [Shots](https://github.com/themindstorm/Shots)
- Add your own

## Documentation

### Installation
Add `swipeable_widget` to your `pubspec.yaml`:

```
dependencies:
  flutter:
    sdk: flutter

  # added below
  swipeable_widget: <latest version>
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
The animation duration that dictates
- How long it takes the widget to move back to the origin
- How long it takes for the widget to animate off the screen

Default value: 120

#### double `sensitivity`
The multiplier value for the position of the widget as it's being moved by the finger. Higher values make the swiping of the widget seem more responsive. If you aim to support a wide screen device, a higher sensitivity value is recommended so that the user doesn't have to swipe the widget all the way to the side.

Default value: 2.0

#### double `horizontalThreshold`
The position the swipeable widget is moved horizontally for it to be moved away. 

This [diagram in this video](https://youtu.be/g2E7yl3MwMk?t=56) may help you visualize the correct position.

Default value: 0.85

#### double `verticalThreshold`
Not implemented yet.

#### double `outsideScreenHorizontalValue`
The position the swipeable should end. If you want the swipeable widget to animate going off screen, this value should be over `1.0`.

**Limitation/Issue**: Finding this value requires some trial and error. Please make a PR if you know off a better way to animate the widget off screen.

#### double `outsideScreenVerticalValue`
Not implemented yet.

#### Function `onHorizontalSwipe`
The function called when the card is moved to either side. If you're making a card game, this is where you would call the function that calls the next card.

#### Function`onVerticalSwipe`
Not implemented yet.

#### Widget `child` (required)
The child widget, which will be swipeable.

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
See the Example.

## Issues and limitation
### `outsideScreenHorizontalValue`
This value should not be required, as it is found through trial and error. We can remove the requirement of this value once we found a way to properly animate a widget going off screen using `Align`.

## Other information
Project start date: 1 May, 2020