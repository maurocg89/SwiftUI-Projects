<div align="center">
  <h1>Project 21: Core Data</h1>
  <h3>Take an in-depth tour of how SwiftUI and Core Data work together.</h3>
</div>

## Topics
 - Why does \.self work for ForEach?
 - Creating NSManagedObject subclasses
 - Conditional saving of NSManagedObjectContext
 - Ensuring Core Data objects are unique using constraints
 - Filtering @FetchRequest using NSPredicate
 - Dynamically filtering @FetchRequest with SwiftUI
 - One-to-many relationships with Core Data and @FetchRequest

##  Challenges
1. Make it accept a string parameter that controls which predicate is applied. You can use Swift’s string interpolation to place this in the predicate.
2. Modify the predicate string parameter to be an enum such as .beginsWith, then make that enum get resolved to a string inside the initializer.
3. Make FilteredList accept an array of SortDescriptor objects to get used in its fetch request.

## Resources
- [Hacking with Swift - Core Data](https://www.hackingwithswift.com/books/ios-swiftui/core-data-wrap-up)
