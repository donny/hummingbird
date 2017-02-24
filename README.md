# hummingbird

Hummingbird is a [Trello](https://trello.com) client for macOS written using [Swift](https://swift.org) 3 and [AppKit](https://developer.apple.com/reference/appkit).

### Background

This project is part of [52projects](https://donny.github.io/52projects/) and the new stuff that I learn through this project: [Swift](https://swift.org) 3, [AppKit](https://developer.apple.com/reference/appkit) (revisit), and [Trello API](https://developers.trello.com) (revisit).

I built a small Trello client for macOS in April last year using Swift 2 and AppKit. Simply because I much preferred native app experience over web experience and I wanted to learn more about AppKit. Hummingbird is a simple rewrite of the app using the new version of Swift.

### Project

Hummingbird was developed using Xcode 8.2 and Swift 3. To build the project, simply download the Xcode project file, open it, and run the app.

There are a few steps that need to be done to access Trello API:

1. Go to https://trello.com/app-key to get the Trello Developer API key
2. Authorize the client: https://trello.com/1/authorize?expiration=never&name=Hummingbird&key=KEY_FROM_STEP1&response_type=token
3. Make calls: https://api.trello.com/1/members/me/boards?key=KEY_FROM_STEP1&token=TOKEN_FROM_STEP2

When you run Hummingbird for the first time, open its Preferences window to enter the Trello token.

The screenshot of the app is shown below:

![Screenshot](https://raw.githubusercontent.com/donny/hummingbird/master/screenshot.png)

### Implementation

The source files are grouped into three main sections: `Managers`, `Models`, and `Controllers`.

There are two manager classes. [`PreferenceManager.swift`](https://github.com/donny/hummingbird/blob/master/Hummingbird/PreferenceManager.swift) acts as an interface to `UserDefaults` and it's responsible for saving and retrieving the Trello token key. [`NetworkManager.swift`](https://github.com/donny/hummingbird/blob/master/Hummingbird/NetworkManager.swift) is responsible for making network calls and transforming the JSON results into data models.

The data models are represented as Swift `struct` in: [`Board.swift`](https://github.com/donny/hummingbird/blob/master/Hummingbird/Board.swift), [`List.swift`](https://github.com/donny/hummingbird/blob/master/Hummingbird/List.swift), [`Card.swift`](https://github.com/donny/hummingbird/blob/master/Hummingbird/Card.swift), [`Label.swift`](https://github.com/donny/hummingbird/blob/master/Hummingbird/Label.swift), [`Member.swift`](https://github.com/donny/hummingbird/blob/master/Hummingbird/Member.swift), and [`Sticker.swift`](https://github.com/donny/hummingbird/blob/master/Hummingbird/Sticker.swift).

Hummingbird uses `NSCollectionView` for the container views and they are implemented using Storyboard and Interface Builder.

### Conclusion

I like Swift and it's been getting better with each successive version. Although, I have to say that I think the language is getting _bigger_ with more keywords and concepts. It's definitely a complex language compared to its older and simpler sibling, the C language. In this project, I got the chance to revisit AppKit development and the Trello API. AppKit is getting more powerful and easier to take since Apple introduces a lot of UIKit-inspired frameworks, for example, `NSCollectionView`. I'm looking forward to use Swift 3 for server side development in future projects.
