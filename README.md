# **`Queen Palace 🏰👑`**

### [**`discord 🤝`**](https://discord.gg/pa4JVtDCqx)

# Introduction

- inside the palace 🏰 you have `Guard`s and `Handler`s to serve your `Request`s 😉
- batteries included 🔋
  - validation including (`DTO` **OR** `class`) validation ⚔
  - loggers (console/file) 📃
  - middle-wares but we preferrer to call them `Guard`s 💂‍♂️
  - hot-reload ⚡ => `lighthouse`
  - `.yaml` file reader 🍨 => `final dbConnection = await yaml<String>('DB_CONNECTION');`

# Examples

[here you can find examples repository](https://github.com/maxzod/examples)

# greet the queen app

```dart
Future<void> main(List<String> args) async {
  final router = PalaceRouter();
  router.get('/greet_the_queen', (req, res) => res.write('Long Live The Queen'));
  await router.openGates();
}
```

## [you can find quick start guide here ⁉📇](https://maxzod.github.io/palace/)

## **`Core Parts`**

## **`Handler`**

type of functions that

- return `Future` or `void`
- takes tow arguments
  - `Request` req
  - `Response` res

a handler will be triggered when a match happened between the incoming request and the endpoint registered path

## `Request`

wrapper class around dart `HttpRequest`
will contains wrappers around the `dart:io` `HttpRequest` class and the `httpRequest` itself

## `Response`

wrapper class around `dart:io` `HttpResponse`
will have functions ease the process of responding to the incoming requests
like

- `res.json(data?)` will convert the given data to `JSON` and sent it back to the user
- `res.file(path)`
- `res.notFound(data?)` => 404
- `res.internalServerError(data?)` => 500
- `res.accepted(data?)` => 200
- `res.created(data?)` => 201
- and so on....

#### **if you respond to the request you will be ending the request life cycle this means guard still will be working but they can not modify the response any more**

## `PalaceRouter`

- register routes and the handler for each route
- register guards
- open the server
- close the server

### Middleware aka **`Guard`** 💂‍♂️

type of functions that

- return `Future` or `void`
- takes three arguments

  - `Request` req
  - `Response` res
  - `Function` next

guards considered as extra layer before the Handlers layers

a guard can be registered for specific route or as global guard for any kind of requests

a guard can response to incoming requests since the have access to the instance of the incoming request

a guard can preform any kind of logic before or after the handler be triggered
