<div align="center">
  <h1>Project 10: Cupcake Corner</h1>
  <h3>Build an app that sends and receives JSON from the internet</h3>
</div>

## Topics
Codable, URLSession, AsyncImage, validating and disabling forms, haptic effects 


##  Challenges

1. Our address fields are currently considered valid if they contain anything, even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.
2. If our call to placeOrder() fails – for example if there is no internet connection – show an informative alert for the user. To test this, try commenting out the request.httpMethod = "POST" line in your code, which should force the request to fail.
3. For a more challenging task, try updating the Order class so it saves data such as the user's delivery address to UserDefaults. This takes a little thinking, because @AppStorage won't work here, and you'll find getters and settings cause problems with Codable support. Can you find a middle ground?


## Resources

- [Hacking with Swift - Cupcake Corner](https://www.hackingwithswift.com/books/ios-swiftui/cupcake-corner-wrap-up)
