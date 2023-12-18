# weight_tracker

A Flutter application demonstrating a simple weight tracker following Clean Architecture patterns with SOLID principles and abstractions at the core.  The backend authentication and database sources are implemented with Firebase Authentication and Cloud Firestore, however these can be swapped out if necessary, thanks to the abstractions put in place in the Domain and Data layers. The Presentation layer is following a general MVVM presentation architecture, with the view_models dependent on Riverpod as the reactive statemanagement supplying Stream data to the Views for realtime Authentication state changes and Weight Tracker state changes.  Using Clean Architecture and SOLID abstraction, the app is now available for mock testing as well as with concrete dependency injection taking place in the Injector.dart registry.

## Setup Instructions for running the app

Clone this Github repo to your local development environment.
Open the project in your VS Code or Android Studio IDE.
In Terminal, run the following command to retrieve all pubspec dependencies:

flutter pub get

The app is configured to run in iOS, Android, a Web Browser, or MacOS platforms.  
In Terminal, run the following command and when prompted, select the number associated with the desired platform:

flutter run

## Assumptions made

To address the request of making the app testable, I can only assume that the app desires clean abstractions for dependency mocking.  Following Clean Architecture lends itself greatly to this objective and ultimately yields an app that is testable, maintainable, and scalable.

Clean Architeture may be verbose and counterintuitive and may seem to conflict with the requested desire of "Simplicity", but in the end it will yield a "simpler" app to test, maintain and scale over time, so I chose to go this path as it is a proven architecture.


## Link to video of the app in action

https://drive.google.com/file/d/1LwRSmeqBbwee3DR8wiZ0ggxjU37U7thp/view?usp=sharing
