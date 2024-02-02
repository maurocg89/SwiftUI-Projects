<div align="center">
  <h1>Project 17: Flashzilla</h1>
  <h3>Use gestures and haptics to build a learning app.</h3>
</div>

## Topics
 - Gestures
 - Combine
 - allowsHitTesting() for disabling user interactivity
 - contentShape
 - Timer
 - Image interpolation
 - App background state (scenePhase)
 - Accessibility: Differentiate without color, reduce motion, reduce transparency, and more. 

##  Challenges
1. When adding a card, the textfields keep their current text – fix that so that the textfields clear themselves after a card is added.
2. If you drag a card to the right but not far enough to remove it, then release, you see it turn red as it slides back to the center. Why does this happen and how can you fix it? (Tip: think about the way we set offset back to 0 immediately, even though the card hasn’t animated yet. You might solve this with a ternary within a ternary, but a custom modifier will be cleaner.)
3. For a harder challenge: when the users gets an answer wrong, add that card goes back into the array so the user can try it again. Doing this successfully means rethinking the ForEach loop, because relying on simple integers isn’t enough – your cards need to be uniquely identifiable.
4. Make it use documents JSON rather than UserDefaults – this is generally a good idea, so you should get practice with this.
5. Try to find a way to centralize the loading and saving code for the cards. You might need to experiment a little to find something you like!


## Resources
- [Hacking with Swift - Flashzilla](https://www.hackingwithswift.com/books/ios-swiftui/flashzilla-wrap-up)
- https://www.hackingwithswift.com/example-code/language/how-to-use-the-rethrows-keyword
