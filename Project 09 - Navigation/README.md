<div align="center">
  <h1>Project 9: Navigation</h1>
  <h3>Direct your user around your app, either programmatically or using explicit input.</h3>
</div>

## Topics

 - The problem with a simple NavigationLink
 - Handling navigation the smart way with navigationDestination()
 - Programmatic navigation with NavigationStack
 - Navigating to different data types using NavigationPath
 - How to make a NavigationStack return to its root view programmatically
 - How to save NavigationStack paths using Codable
 - Customizing the navigation bar appearance
 - Placing toolbar buttons in exact locations
 - Making your navigation title editable

##  Challenges
 1. Change project 7 (iExpense) so that it uses NavigationLink for adding new expenses rather than a sheet. (Tip: The dismiss() code works great here, but you might want to add the navigationBarBackButtonHidden() modifier so they have to explicitly choose Cancel.)
 2. Try changing project 7 so that it lets users edit their issue name in the navigation title rather than a separate textfield. Which option do you prefer?
 3. Return to project 8 (Moonshot), and upgrade it to use NavigationLink(value:). This means adding Hashable conformance, and thinking carefully how to use navigationDestination().

## Resources
- [Hacking with Swift - Navigation](https://www.hackingwithswift.com/books/ios-swiftui/navigation-wrap-up)
