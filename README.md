# **`Queen Palace 🏰👑`**

server side dart micro-framework to handle incoming http requests

# Introduction

- inside the palace 🏰 you have **`Guard`s** and **`Handler`s** to serve your **`Request`s** 😉
- batteries included 🔋
  - **validation** including (`DTO` **OR** `class`) validation ⚔
  - **loggers** (Console AND File) 📃
  - **middle-wares** but we preferrer to call them **`Guard`s** 💂‍♂️
  - **hot-reload** ⚡ => [`lighthouse`](https://github.com/maxzod/lighthouse)
  - **.yaml** file reader 🍨

### [Here You Can Find The Examples Repository](https://github.com/maxzod/examples)

# Greet The Queen App

```dart
Future<void> main(List<String> args) async {
  final palace = Palace();
  palace.get('/greet_the_queen', (req, res) => res.write('Long Live The Queen 👑'));
  await palace.openGates();
}
```

## [you can find quick start guide here ⁉📇](https://github.com/maxzod/palace/tree/master/../../../../../../doc/index.md)

## **`Core Parts`**

## **`Handler`**

type of functions that

- takes tow arguments

  - `Request` the incoming request
  - `Response` the response to the incoming request

- return `FutureOr<void>`

a handler will be triggered when a match happened between the incoming request and the registered endpoint path and method

### `Request` class

wrapper class around `dart:io` `HttpRequest` with extra functions and getters to make your life easier.

### `Response` class

wrapper class around `dart:io` `HttpResponse` with extra functions and getters also to make the same life easier .

some of these functions are

- `res.json(data?)` will convert the given data to `JSON` and sent it back to the user
- `res.file(path)` give it path and it will give the file to the user
- `res.notFound(data?)` => 404
- `res.internalServerError(data?)` => 500
- `res.accepted(data?)` => 200
- `res.created(data?)` => 201

and so on....

## `Palace` class

- register routes and the handler for each route
- use guards 'palace.use(CORSGuard())' for example,
- open the server
- close the server

### Middleware aka **`Guard`** 💂‍♂️

typedef of functions that

- takes three arguments

  - `Request` req
  - `Response` res
  - `Function` next

- return `Future` or `void`
- guards considered as extra layer before the Handlers layers
- they can be registered for specific route or as global guard for any kind of requests
- they can response to incoming requests since they have access to the incoming request
- they can preform any kind of logic before or after the handler be triggered

# PalaceException class

you can throw them from any where from your application
so guards can and handlers can or even the services can throw them

but what will happened then ?
the palace will catch the exception format it to json including the given data object - if one was provided -
and end the request life cycle

- here some of them
- `BadRequest(data?)`
- `NotFound(data?)`
- `Unauthorized(data?)`
