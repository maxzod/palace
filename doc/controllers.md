# PALACE CONTROLLERS

## TAKES

```dart
@Get('/path')
@Guards([])
FutureOr<void> findOne(req,res)


}
```

register it as endpoint

```dart
palace.get('/path',findOne);
```

# `Table of Contents`

- [PALACE CONTROLLERS](#palace-controllers)
  - [TAKES](#takes)
- [`Table of Contents`](#table-of-contents)
  - [how to register controllers](#how-to-register-controllers)
  - [how to build controller](#how-to-build-controller)

## how to register controllers

```dart
final palace = Palace([globalGuards]?);
palace.controllers(
   [
      PalaceController(),
      PalaceController(),
      PalaceController(),
   ]
)
```

## how to build controller

```dart


class UsersController extends PalaceController{

   UsersController():super('/users');

  @Get()
  @UseGuard()
  @UseGuards([])

  Future<void> findOne(Request req , Response res) async {
   //    GET => /users
  }

  @Post('/:id')
  Future<void> createOne(Request req , Response res) async {
     // POST => /users/5
  }

  @Delete('/:id')
  Future<void> deleteOne(Request req , Response res) async {}

  @Put('/:id')
  Future<void> updateOne(Request req , Response res) async {}


 }

```

<!-- ```dart``` -->
<!-- ```dart``` -->
<!-- ```dart``` -->
<!-- ```dart``` -->
