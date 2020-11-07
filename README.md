# EzPokemon

EzPokemon is a project written in MVVM with RxSwift, using the api available at https://pokeapi.co

## Project guidelines

- [x] Use Swift 5.3
- [x] Use iOS 11 SDK as Target
- [x] The UI must be created without the use of Xib or Storyboard, it must be dynamic and must support both iPhone and iPad
- [x] Use a maximum of two external libraries and motivate their use
- [x] You can use CocoaPods, Carthage or SwiftPM giving reasons for your choice
- [x] Use the MVVM pattern
- [x] Check that the build is successful before submitting the project
- [x] Submit the code by publishing it to a public repository
- [x] Create a README.md in which you explain the reason for your implementation choices.

### Bonus Tasks

- [x] Make maximum use of one external library
- [ ] Make the app work even offline
- [ ] Write Unit Tests

Customize the project with something you think will be useful for this app.

## Considerations

An MVVM pillar is known to be data binding. There are two well-known responsive frameworks that could have helped accomplish this task: Combine and RxSwift.

One of the constraints of the project is to use iOS 11 as a deployment target, so RxSwift (and therefore RxCocoa) was a mandatory choice, because Combine is only available starting with iOS 13.

Swift Package Manager was my first choice to integrate external libraries, in order to do it the "Xcode native way", avoiding the creation of a workspace with a new Pod target used in CocoaPods.
RxSwift has known problems with SPM, so I decided the safe way of CocoaPods.

I only used RxCocoa (and therefore RxSwift) as an external library. The other library is "Utilities", written by me as a Development Pod. It is, for now, local. It should be versioned in order to be upgraded and reused in the future.

The app stores images in NSCache. For now, the app only works with the network connection. It should store data in order to work offline and avoid repeating the API call.

## Requirements

- iOS 11.0+
- Xcode 12+
- Swift 5.3+

## Credits

I DON'T own ANYTHING about pokeapi, RxSwift or other external libraries/api used or linked inside the project. This is just a test project.
