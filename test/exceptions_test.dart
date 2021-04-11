// import 'package:dio/dio.dart';
// import 'package:palace/palace.dart';
// import 'package:palace/src/exceptions/imp_exception.dart';
// import 'package:palace/src/exceptions/not_found.dart';
// import 'package:test/test.dart';

// void main() {
//   late Palace palace;
//   final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000', validateStatus: (_) => true));
//   setUp(() async {
//     palace = Palace();
//     await palace.openGates();
//   });
//   tearDown(() async {
//     await palace.closeGates();
//   });

//   test('end with exception from the handler', () async {
//     palace.all('/', (req, res) => throw NotFound());
//     final response = await _dio.get('/');
//     expect(response.statusCode, equals(HttpStatus.notFound));
//   });
//   test('end with exception from first guard will not make the request reach the next one or the handler', () async {
//     palace.all('/', (req, res) => res.accepted(), guards: [
//       (req, res, next) => throw NotFound(),
//       (req, res, next) => res.created(),
//     ]);
//     final response = await _dio.get('/');
//     expect(response.statusCode, equals(HttpStatus.notFound));
//   });
//   test('unknown exceptions will be formatted to internal server error', () async {
//     palace.all('/', (req, res) => res.accepted(), guards: [
//       (req, res, next) => next(),
//       (req, res, next) => throw "you don't know what you don't now",
//       (req, res, next) => res.created(),
//     ]);
//     final response = await _dio.get('/');
//     expect(response.statusCode, equals(HttpStatus.internalServerError));
//   });
// }
