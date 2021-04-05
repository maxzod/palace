# Palace

## Welcome

You can use the palace to build server side dart application easily
palace will provide you with simple yet power-full API to build your app

# Get Started

- create new dart project
- depend on `palace: <latest-version>`

## Hello world app

```dart
Future<void> main(List<String> args) async {
  final palace = PalaceRouter();
  palace.get('/greet_the_queen', (req, res) => res.write('Long Live The Queen'));
  await palace.openGates();
}
```

**just like that in three lines**

## hello world in depth

### line 1 : `PalaceRouter` is your server application which will help you to

1. register endpoints to
2. handle requests for non-registered endpoints "Not found Handler"
3. close the server

this is what you need to know about the router for now (it can do more but we will keep simple for introduction)

### line 2 : `get` method

within the place instance you cant register end point for specific router and specific http method for example

- `palace.get(path,handler)`
- `palace.post(path,handler)`
- `palace.put(path,handler)`
- `palace.delete(path,handler)`

  _OR_

you can set handler for any type of http method

- `palace.all(path,handler)`

### line 3 : `palace.openGates()`

will open the server and start to listen for incoming requests if there is a match with one of your registered endpoints it will trigger the responsible handler for this endpoint

but if there is not a match it will respond with 404 response - you can customize this behavior-
