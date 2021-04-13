// import 'dart:io';
// import 'package:palace/palace.dart';

// class Whitelisted {
//   void call(Request req, Response res, Function next) async {
//     var whitelist = await addressWhitelist;
//     if (whitelist!.contains(req.ip)) {
//       return await next();
//     } else {
//       return await res.json(
//           {'address': req.ip, 'message': "You're not whitelisted"},
//           statusCode: HttpStatus.unauthorized);
//     }
//   }
// }

// class Blacklisted {
//   void call(Request req, Response res, Function next) async {
//     var blacklist = await addressBlacklist;
//     if (blacklist!.contains(req.ip)) {
//       return await res.json(
//           {'address': req.ip, 'message': 'Your IP is banned and blacklisted'},
//           statusCode: HttpStatus.unauthorized);
//     } else {
//       return await next();
//     }
//   }
// }
