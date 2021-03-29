# **`Part of Queen Palace 🏰👑`**

🚧 Palace Is Under Construction 🚧 👷

🔑 Gates Will Open ASAP

✔️ Stay Safe

👑 Stay inside the kingdom

# take look at bin/main

- to run use dart `bin/main.dart`
- use `lighthouse` for `run` && `watch` for changes
  `lh bin/main.dart`
- there is a lot to do you are welcome to help building your `palace`

# example

if you want to test your self clone and run `bin/main.dart`

```dart
Future<void> main(List<String> args) async {

  final palace = PalaceRouter();

  palace.use(LoggerGuard());

  palace.get('/greet_the_queen', (req, res) async {
    return res.json({'data': 'Long Live The Queen'});
  });

  /// start the `server`
  await openGates(palace);
}
```

## Core Parts

## `Request`

wrapper class around dart `HttpRequest`
mostly will be getters to ease extracting values form the `HttpRequest`

## `Response`

wrapper class around dart `HttpResponse`
will have functions ease the process of responding to the incoming requests

## `PalaceGuard`

abstract class with one function to execute before giving the http request for the handler witch meas if you responds to the request form any guards the requests will not reach the next guards or even the endpoint handler it self
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
