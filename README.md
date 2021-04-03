# **`Queen Palace 🏰👑`**

# Introduction

- inside the palace 🏰 you are a king 🤴 you have `Guards` and `Handlers` to serve your `Requests` 😉
  micro-framework with batteries included 🔋
  i will not lie this package is heavily inspired by `ExpressJs` 😆😆

- but with little bit more features 🤴
- built-in validation including (DTO/class) validation ⚔
- built-int loggers (console/file) 📃
- middle-wares but we preferrer to call Guards they can work globally or you can assign them to specific routes 💂‍♂️
- hot-reload ⚡

# Disclaimer

- the palace still in beta stage if you have a reliable replacement you should go with them
  until we finish the palace

  **`BUT`** 95% the api will still the same 💡

- 💙 support us by like and star the package on github and pub.dev and watch for new releases

# Example

```dart
Future<void> main(List<String> args) async {

  final router = PalaceRouter();


  router.get('/greet_the_queen', (req, res) => res.write('Long Live The Queen'));

  /// start the `server`
  await openGates(router);
}
```

## Core Parts

## `Request`

wrapper class around dart `HttpRequest`
mostly will be getters to ease extracting values form the `HttpRequest`

## `Response`

wrapper class around dart `HttpResponse`
will have functions ease the process of responding to the incoming requests

#### **`if you response to the request you will be ending the request life cycle`**

## `PalaceRouter`

to help you set routes and the handler for each route

## `palace`

the palace file contains only one function `openGates(PalaceRouter,{port})` which takes palace router and will start server
wait for incoming requests
transforming them to Request object
find the right endpoint if not found will respond with 404
if exist will loop throw the guards and the endpoint handler then close the IO request
