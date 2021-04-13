// import 'dart:async';
// import 'package:palace/palace.dart';
// import 'package:palace/src/decorators/handler_param.dart';

// class CorsGuard extends PalaceGuard {
//   final int age = 86400;
//   final String headers = 'Content-Type';
//   final String methods = 'POST, GET, PUT, DELETE';
//   final String origin = '*';
//   const CorsGuard(
//       {int age = 86400,
//       String headers = 'Content-Type',
//       String methods = 'POST, GET, PUT, DELETE',
//       String origin = '*'});

//   @override
//   FutureOr<void> handle(Request req, Response res, @Next() next) async {
//     res.headers.set('Origin', origin);

//     res.headers.set('Access-Control-Allow-Origin', origin);
//     res.headers.set('Access-Control-Allow-Methods', methods);
//     res.headers.set('Access-Control-Allow-Headers', headers);
//     res.headers.set('Access-Control-Expose-Headers', ['X-My-Custom-Header','X-My-Custom-Header']);
//     res.headers.set('Access-Control-Max-Age', age);

//     return await next();
//   }
// }
