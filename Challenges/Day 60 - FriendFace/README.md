<div align="center">
  <h1>Milestone 5: Projects 10-12</h1>
</div>

##  Challenge
It’s time for you to build an app from scratch, and it’s a particularly expansive challenge today: your job is to use URLSession to download some JSON from the internet, use Codable to convert it to Swift types, then use NavigationStack, List, and more to display it to the user.

Your first step should be to examine the JSON. The URL you want to use is this: https://www.hackingwithswift.com/samples/friendface.json – that’s a massive collection of randomly generated data for example users.

As you can see, there is an array of people, and each person has an ID, name, age, email address, and more. They also have an array of tag strings, and an array of friends, where each friend has a name and ID.

How far you implement this is down to you, but at the very least you should:

- Fetch the data and parse it into User and Friend structs.
- Display a list of users with a little information about them, such as their name and whether they are active right now.
- Create a detail view shown when a user is tapped, presenting more information about them, including the names of their friends.
- Before you start your download, check that your User array is empty so that you don’t keep starting the download every time the view is shown.

## Resources
- [Hacking with Swift - Milestone 5](https://www.hackingwithswift.com/guide/ios-swiftui/5/3/challenge)
