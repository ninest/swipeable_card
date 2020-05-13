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
if (currentCardIndex < cards.length)
  SwipeableWidget(
    cardController: _cardController,
    animationDuration: 500,
    horizontalThreshold: 0.85,
    // (1)
    child: cards[currentCardIndex],
    nextCards: <Widget>[
      // show next card
      // if there are no next cards, show nothing
      if (!(currentCardIndex + 1 >= cards.length))
        // (2)
        Align(
          alignment: Alignment.center,
          child: cards[currentCardIndex + 1],
        ),
    ],
    onLeftSwipe: () => swipeLeft(),
    onRightSwipe: () => swipeRight(),
  )
else
  // if the deck is complete, add a button to reset deck
  Center(
    child: FlatButton(
      child: Text("Reset deck"),
      onPressed: () => setState(() => currentCardIndex = 0),
    ),
  ),
```

### What's going on here?

See the comments in the code for the labels `(1)` and `(2)`.

1. This is the card on top which the user sees. It is a `SwipeableWidget`, so users can interact with it and swipe it away. It's child is the `cards[currentCardIndex]`, so it is the 1st card initially.

2. This is the card **behind** the current card. The user **cannot** interact with it. It is `cards[currentCardIndex + 1]`, so it's the 2nd card initially. You may put as many widgets as you want in `nextCards`. They will be stacked over each other.

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

**In short**, the card in the `nextCards` list. Try removing it to see what happens!

**Note:** It is your job to handle showing the user the next card. In this simple example, to show the next card, all that needs to be done is add `1` to `currentCardIndex`. This is done by the `onLeftSwipe` and `onRightSwipe` functions:

```
void swipeLeft() {
  print("card swiped to the left");

  // going to next card
  setState(() {
    currentCardIndex++;
  });
}

void swipeRight() {
  print("card swiped to the left");

  // going to next card
  setState(() {
    currentCardIndex++;
  });
}
```

### What about the `if` statements?

They're just there to prevent the app from erroring when the user has reached the end of the deck. When the user is on the last purple card, they won't see a card behind it. And once this last card is swiped, a button will be shown which resets the deck on press.

By resetting the deck, it just sets `currentCardIndex` to `0`. If you're making a game, you may want to get a new list of cards or randomize the the order of the cards first.

## Using the `SwipeableWidgetController`
This allows you to swipe the cards without having the user touch or pan them.

Pass the `SwipeableWidgetController` like so:

```
SwipeableWidgetController _cardController = SwipeableWidgetController();
...
SwipeableWidget(
  cardController: _cardController,
  ...
)
```

Now you can call the following functions:
- `_cardController.triggerSwipeLeft()`
- `_cardController.triggerSwipeRight()`

Check out the `cardControllerRow` widget:

```
Widget cardController(SwipeableWidgetController cardController) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      FlatButton(
        child: Text("Left"),
        onPressed: () => cardController.triggerSwipeLeft(),
      ),
      FlatButton(
        child: Text("Right"),
        onPressed: () => cardController.triggerSwipeRight(),
      ),
    ],
  );
}
```

Tapping on the buttons swipes the cards to the left and right respectively.

## Improvements you can make
### 1. Make cards look more natural
To do this, you can use the `Tranform` widgets to rotate the cards by a randomly generated angle, or even change the offset.

### 2. Disable users from swiping cards
If you do need to disable a card, wrap `SwipeableWidget` with `IgnorePointer`. Check out [this video](https://www.youtube.com/watch?v=qV9pqHWxYgI) for more information.