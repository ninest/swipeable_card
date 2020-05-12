# Swipeable Card Example

## Explanation (see `example_route.dart`)
We have a list of containers (the "cards") that we would like the user to swipe. This beahviour is commonly seen in card games or dating apps.

```
// CardExample is a custom container with a nice border and rounded corners
final List<CardExample> cards = [
  CardExample(color: Colors.red, text: "First card"),
  CardExample(color: Colors.blue, text: "Second card"),
  CardExample(color: Colors.orange),
  CardExample(color: Colors.indigo),
  CardExample(color: Colors.green, text: "The next card is the last"),
  CardExample(color: Colors.purple, text: "This is the last card"),
];
```

The user should first see the card "First card", which is red, so the `currentCardIndex` is initialized to `0`.

In the `Scaffold`, we see an `Align` widget with the following children:

```
// (2)
if (!(currentCardIndex + 1 >= cards.length))
  Align(
    alignment: Alignment.center,
    child: cards[currentCardIndex + 1],
  ),

// (1)
if (currentCardIndex < cards.length)
  SwipeableWidget(
    outsideScreenHorizontalValue: 8.0,
    child: cards[currentCardIndex],
    // move to next card when top card is swiped away
    onHorizontalSwipe: () => setState(() => currentCardIndex++),
  )

else
  // display button to "reset deck" 
  // (the widget here will only show when current card index is equal to the length of cards list)
```

### What's going on here?

See the comments in the code for the labels `(1)` and `(2)`.

1. This is the card on top which the user sees. It is a `SwipeableWidget`, so users can interact with it and swipe it away. It's child is the `cards[currentCardIndex]`, so it is the 1st card initially.

2. This is the card **behind** the current card. It is **not** wrapped by the `SwipeableWidget`, so the user cannot interact with it. It is `cards[currentCardIndex + 1]`, so it's the 2nd card initialilly.

As the value of `currentCardIndex`, increases, the card the user sees (1) and card behind that (2) are both increased appropriately.

So when the front card (1) is swiped, `currentCardIndex++` is called. This gives an **appearance** that the card has moved away. What's actually happened is that the `SwipeableWidget` is putting itself back (with the next card) in the center right after it's animated out.

#### What seems to be happening?

This is what the users see:

1. The card is discarded (gone)
2. Next card comes into focus

#### What actually happens? This is what's going on under the hood.

1. The card is animated out of the screen
2. After a delay, the card is moved back to the center without any animaton.
3. Using state management (`setState` in this case) to show the next card.

**In short**, the card behind the one wrapped in `SwipeableWidget` is a dummy card. Try removing it to see what happens!

### What about the `if` statements?

They're just there to prevent the app from erroring when the user has reached the end of the deck. When the user is on the last purple card, they won't see a card behind it. And once this last card is swiped, a button will be shown which resets the deck on press.

By resetting the deck, it just sets `currentCardIndex` to `0`. If you're making a game, you may want to get a new list of cards or randomize the the order of the cards first.

## I want to swipe the cards to the top and bottom too

Make use of the following properties:
- `enableVerticalSwiping`
- `outsideScreenVerticalValue`
- `onVerticalSwipe`

### Example

Replace the `SwipeableWidget( ... )` from `home_route.dart` to

```
SwipeableWidget(
  // add this
  enableVerticalSwiping: true,

  outsideScreenHorizontalValue: 8.0,

  // add this
  outsideScreenVerticalValue: 8.0,

  child: cards[currentCardIndex],

  onHorizontalSwipe: () => setState(() => currentCardIndex++),

  // add this
  onVerticalSwipe: () => setState(() => currentCardIndex++),
)
```

Once again, some trial and error is required to correctly set the value of `outsideScreenVerticalValue`. You may specify a different function that executes when the card is swiped away vertically.

Once you have set the above modified `SwipeableWidget`, run the example and try swiping the card to the top and bottom!

## Automatically swiping cards (without user manually swiping) (see `controller_example_route.dart`)

Check out `controller_example_route.dart`. First, go to `main.dart` and set the child of `MaterialApp` to `ControllerExampleRoute`:

```
return MaterialApp(
  ...
  home: ControllerExampleRoute(),
);
```

Run the app and use the buttons at the bottom of the screen to swipe cards.

For example, to swipe the card to the left, tap the "left" button: 

```
FlatButton(
  child: Text("left"),

  // The below function automatically swipes the card
  onPressed: () => _swc.triggerHorizontalSwipeLeft(),
),
```

## Improvements you can make
### 1. Make cards look more natural
To do this, you can use the `Tranform` widgets to rotate the cards by a randomly generated angle, or even change the offset.

### 2. Disable users from swiping cards
If you do need to disable a card, wrap `SwipeableWidget` with `IgnorePointer`. Check out [this video](https://www.youtube.com/watch?v=qV9pqHWxYgI) for more information.