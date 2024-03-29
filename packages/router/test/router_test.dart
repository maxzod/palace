// import 'dart:io';

// import 'package:dio/dio.dart' hide Response;
// import 'package:palace/config.dart';
// import 'package:palace/palace_router.dart';
// import 'package:test/test.dart';

// void main() {
//   late Palace router;

//   final _dio = Dio(BaseOptions(
//       baseUrl: 'http://localhost:3000',
//       followRedirects: true,
//       validateStatus: (_) => true,
//       contentType: 'application/json'));

//   setUp(() async {
//     router = Palace();
//     await router.openGates();
//   });
//   tearDown(() async {
//     await router.closeGates();
//   });
//   test('custom not found', () async {
//     PalaceConfig.notFoundHandler =
//         (req, res) => throw NotFound('custom not found handler msg');
//     final res = await _dio.get('/some_unknown_place');
//     expect(res.statusCode, HttpStatus.notFound);
//     expect(
//         res.data,
//         equals({
//           'status_code': 404,
//           'message': 'Not found',
//           'data': 'custom not found handler msg'
//         }));
//   });
//   test('all', () async {
//     router.all('/', (req, res) => res.send('hello world'));
//     final responseGet = await _dio.get('/');
//     expect(responseGet.data, equals('hello world'));
//     final responsePost = await _dio.get('/');
//     expect(responsePost.data, equals('hello world'));
//     final responsePut = await _dio.get('/');
//     expect(responsePut.data, equals('hello world'));
//     final responseDELETE = await _dio.get('/');
//     expect(responseDELETE.data, equals('hello world'));
//   });
//   test('get', () async {
//     router.get('/', (req, res) => res.send('hello world'));
//     final response = await _dio.get('/');
//     expect(response.statusCode, HttpStatus.ok);
//     expect(response.data, equals('hello world'));
//   });
//   test('match with one segment', () async {
//     router.get('/users/:id', (req, res) => res.send('/users/:id'));
//     final response = await _dio.get('/users/66');
//     expect(response.data, equals('/users/:id'));
//   });
//   test('match path with tow segments', () async {
//     router.get('/users/:id/sub', (req, res) => res.send('/users/:id/sub'));
//     final response = await _dio.get('/users/66/sub');
//     expect(response.statusCode, HttpStatus.ok);
//     expect(response.data, '/users/:id/sub');
//   });
// }
