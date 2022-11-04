# Restaurant App

<img src="https://user-images.githubusercontent.com/44419939/199880398-8d46c761-b1a2-4f36-97a7-bbe7eddf61e3.png" alt="Mockup" class="center" width="400" height="500">

A simple Flutter project about mobile app to help user find popular restaurant. This project idea come from Dicoding Indonesia course.

## Technology Usage

This project use Provider as State Management. Provider has many concepts, they are :
1. SharedState : save the state of a widget
2. ChangeNotifier : notify when state changes in sharedstate (locate at sharedstate)
3. Consumer : catch changes to the state in use (locate at parent widget that will use state)
4. ChangeNotifierProvider : provides the created sharedstate object (locate at parent of MaterialApp)

I also implement other flutter packages. they are :
1. cached network image
2. sqlite
3. alarm manager
4. shared preference
5. build runner and mockito for unit testing

