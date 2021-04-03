# **`Queen Palace 🏰👑`**

# Introduction

- inside the palace 🏰 you are a king 🤴 you have `Guards` and `Handlers` to serve your `Requests` 😉
  micro-framework with batteries included 🔋
  i will not lie this package is heavily inspired by `ExpressJs` 😆😆
  \n
- but with little bit more features 🤴
- built-in validation including (DTO/class) validations ⚔
- built-int loggers (console/file) 📃
- middle-wares but we preferrer call Guards the can work globally or you can assign them to specific routes 💂‍♂️
- hot-reload ⚡

# Disclaimer

- the palace still in beta stage if you have a reliable replacement you should go with them
  until we finish the palace , support us wil like and star on github and watch for new releases

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

**if you response to the request you will be ending the request life cycle**

- in case of ending

## `PalaceRouter`

to help you set routes and the handler for each route

## `palace`

the palace file contains only one function `openGates(PalaceRouter,{port})` which takes palace router and will start server
wait for incoming requests
transforming them to Request object
find the right endpoint if not found will respond with 404
if exist will loop throw the guards and the endpoint handler then close the IO request
