# **`Queen Palace 🏰👑`**

# Introduction

server side dart micro-framework to handle incoming http requests

## hello world app

```dart
Future<void> main(List<String> args) async {
  final palace = Palace();
  palace.get('/greet_the_queen', (req, res) => res.send('Long Live The Queen 👑'));
  await palace.openGates();
}
```

## hello world with decoration

decoration will help you split your code to parts or modules easily making the application easy to maintain

```dart
void main(List<String> args) async {
  final palace = Palace();
  palace.controllers([MainController()]);
  await palace.openGates();
}

class MainController extends PalaceController {
  MainController() : super('/');

  @Get()
  void greeTheQueen(Request req, Response res) {
    return res.send('Long Live The Queen 👑');
  }
}
```

## **`Core Parts`**

## `Palace` class

- register routes and the call back for each route
- use guards 'palace.use(CORSGuard())' for example
- open the server
- close the server

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

### Middleware aka **`Guard`** 💂‍♂️

a simple function

- return `void`
- takes any parameters you want starting from 0 parameters or the entire parameters list (see the parameters list down below)
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

## **`Callback Parameters`**

if you are using the decoration you can get extra push to your endpoint callback or the guards
you can extract these type of data from the incoming request

- without decorations you can get access to the incoming request or the response by declaring the type of them

```dart
  @Get()
  void sayHi(Request req,Response Res) {
    //logic
    }
```

need to aces the request body directly and strong typed ?
use `@Body()` decorator

```dart
class SignUpBody{
  late String name;
  late String email;
  late String password;
}
  @Post()
  void signUp(Request req,Response Res,@Body() SignUpBody body) {
    //logic
    }
```

need to access specific value from the body ?

```dart
@Body('key') String email
```

the same goes for

```dart
@Query()
@QueryParam()
@Param()
```

if you are building a guard use

```dart
@Next()
```

to get access to the next callback
