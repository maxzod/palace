// Object signIn(@Body() SignInDto dto, @Body('email') String email) async {
//   // * this func will not be call unless dto is has valid data
//   // * from the req body
// }

// class UserServices {
//   final AuthService authService;

//   UserServices(this.authService);

//   void foo() {
//     // * the palace will find the auth service and inject it
//     // *  throw the construactor you dont need to do any thing;
//   }
// }
library core;

/// ? `http` 🌍
export 'package:core/src/http/request/request.dart';
export 'package:core/src/http/responses/response.dart';

/// ? utils 🛠
export 'package:core/src/utils/file_helper.dart';

/// ? Request
export 'package:core/src/http/endpoint/typedef.dart';

/// ? responses
export 'package:core/src/http/responses/index.dart';

/// ? ext
export 'package:core/src/http/request/req.dart';
