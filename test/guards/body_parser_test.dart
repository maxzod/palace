// import 'dart:io';

// import 'package:dio/dio.dart' hide Response;
// import 'package:palace/palace.dart';
// import 'package:test/test.dart';

// void main() {
//   late Palace router;

//   final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000', followRedirects: true, validateStatus: (_) => true));

//   setUp(() async {
//     router = Palace();
//     await router.openGates();
//   });
//   tearDown(() async {
//     await router.closeGates();
//   });
//   test('if no body then will body will be empty', () async {
//     router.get('/home', (Request req, Response res) => res.json(req.body));
//     final res = await _dio.get('/home');
//     expect(res.statusCode, equals(HttpStatus.ok));
//     expect(res.data, equals({}));
//   });

//   test('application/json', () async {
//     router.post('/home', (Request req, Response res) => res.send(req.body['name']));
//     final res = await _dio.post('/home', options: Options(contentType: 'application/json'), data: {'name': 'queen'});
//     expect(res.data, equals('queen'));
//   });
//   test('application/x-www-form-urlencoded', () async {
//     router.post('/home', (Request req, Response res) => res.send(req.body['name']));
//     final res = await _dio.post('/home', options: Options(contentType: 'application/x-www-form-urlencoded'), data: {'name': 'queen'});
//     expect(res.data, equals('queen'));
//   });
//   test('multipart/form-data', () async {
//     router.post('/home', (Request req, Response res) => res.send(req.body['name']));
//     final res = await _dio.post('/home', options: Options(contentType: 'multipart/form-data'), data: {'name': 'queen'});
//     expect(res.data, equals('queen'));
//   });
// }
