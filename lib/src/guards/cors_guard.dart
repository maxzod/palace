// import 'package:palace/palace.dart';
// import 'package:palace/src/decorators/handler_param.dart';

// class CorsGuard {
//   int age = 86400;
//   String headers = 'Content-Type';
//   String methods = 'POST, GET, PUT, DELETE';
//   String origin = '*';
//   CorsGuard(
//       {int age = 86400,
//       String headers = 'Content-Type',
//       String methods = 'POST, GET, PUT, DELETE',
//       String origin = '*'});
//   Future<void> call(Request req, Response res, Function next) async {
//     //req.headers.set('Origin', origin);
//     //req.headers.set('Access-Control-Request-Method', methods);
//     //req.headers.set('Access-Control-Request-Headers', headers);

//     res.headers.set('Access-Control-Allow-Origin', origin);
//     res.headers.set('Access-Control-Allow-Methods', methods);
//     res.headers.set('Access-Control-Allow-Headers', headers);
//     res.headers.set('Access-Control-Max-Age', age);

//     return await next();
//   }
// }
