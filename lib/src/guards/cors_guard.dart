import 'dart:async';
import 'package:palace/palace.dart';

class CorsGuard {
  final int age = 86400;
  final String headers = 'Content-Type';
  final String methods = 'POST, GET, PUT, DELETE';
  final String origin = '*';
  const CorsGuard({int age = 86400, String headers = 'Content-Type', String methods = 'POST, GET, PUT, DELETE', String origin = '*'});

  FutureOr<void> call(Request req, Response res, Function next) async {
    res.headers.set('Origin', origin);

    res.headers.set('Access-Control-Allow-Origin', origin);
    res.headers.set('Access-Control-Allow-Methods', methods);
    res.headers.set('Access-Control-Allow-Headers', headers);
    res.headers.set('Access-Control-Expose-Headers', ['X-My-Custom-Header', 'X-My-Custom-Header']);
    res.headers.set('Access-Control-Max-Age', age);

    return await next();
  }
}
