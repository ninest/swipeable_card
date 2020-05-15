<!-- omit in toc -->
# Swipeable Card (v1.x.x)

**Add swipeable card-like widgets for games or interactive onboarding screens**

[![Pub](https://img.shields.io/pub/v/swipeable_card.svg?style=flat-square)]()
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
![lic](https://img.shields.io/github/license/themindstorm/swipeable_card?style=flat-square)
[![BMAC](https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-orange.svg?style=flat-square)](https://www.buymeacoffee.com/ninest) 


## Contents
- [Examples](#Examples)
- [Documentation](#Documentation)
- [Issues and limitations](#Issues-and-limitations)
- [Other information](#Other-information)

## 🎮 Examples

### Demo

#### `SwipeableWidget` (meant for high performance devices, like iPhones)
<!-- <img alt="Demo 1" src="./readme-assets/demo-1.gif" height="500">  -->
<img alt="Demo 1" src="https://github.com/ninest/swipeable_card/blob/v1.x.x/readme-assets/demo-1.gif?raw=true" height="500"> 

#### `SwipeableWidgetSlide` (meant for lower performance devices, like older Android devices)

- Demo of `SwipeableWidgetSlide` to be added

Check the [repository](https://github.com/ninest/swipeable_card) if you're unable to see the demo.

### App examples
Swipeable Widget is used in the following apps:
- [Shots](https://github.com/ninest/Shots)
- Create a PR to add your own!

## 📒 Documentation

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

The swipeable widget has to be placed in a `Column` (or `Row`), for example:

```
Column(
  children: <Widget>[
    SwipeableWidget(
      // parameters ...
      child: someChildWidget(),
    ),
  ],
)
```

In the above example, replace `someChildWidget()` with the widget that can be swiped (for example, a playing card-like widget).

Warning: while `SwipeableWidget` is fast on iPhones, it can be quite slow for older Android devices. I am currently working on `SwipeableWidgetSlide`, an alternative which can be used for older Android devices.

Check out [https://swipeable-card.now.sh/](https://swipeable-card.now.sh/) for the full documentation (still a work in progress).


## 😐 Issues and limitations

If you use the a `swipeableWidgetController` to automatically swipe the cards (without the user panning), you can only start swiping the next card away when the previous one is fully swiped away. To see a demo, run the example, and continuously tap the "Left" button at the bottom of the screen.

Apart from that, all the other problems from v0.0.x seem to be dealth with.

## License
BSD 2-clause

## 📝 Other information
Project start date: 1 May, 2020.

<!-- This package was extracted from my app [Shots](https://github.com/themindstorm/Shots). Check it out! -->