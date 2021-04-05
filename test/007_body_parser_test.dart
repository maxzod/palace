import 'dart:io';

import 'package:dio/dio.dart';
import 'package:palace/palace.dart';
import 'package:test/test.dart';

void main() {
  late Palace router;

  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000', followRedirects: true, validateStatus: (_) => true));

  setUp(() async {
    router = Palace();
    router.use(BodyParser());
    await router.openGates();
  });
  tearDown(() async {
    await router.closeGates();
  });
  test('if no body then will fail abd respond with bad request', () async {
    router.all('/home', (req, res) => res.write(req.bodyType!));
    final res = await _dio.post('/home');
    print(res.data);
    expect(res.statusCode, equals(HttpStatus.badRequest));
  });
  test('every thing is fine with application/json', () async {
    router.post('/home', (req, res) => res.write(req.bodyType!));
    final res = await _dio.post('/home', options: Options(contentType: 'application/json'), data: {'name': 'queen'});
    expect(res.data, equals('json'));
  });
  test('every thing is fine with application/x-www-form-urlencoded', () async {
    router.post('/home', (req, res) => res.write(req.body['name']));
    final res = await _dio.post('/home', options: Options(contentType: 'application/x-www-form-urlencoded'), data: {'name': 'queen'});
    expect(res.data, equals('queen'));
  });
  test('every thing is fine with multipart/form-data', () async {
    // router.post('/home', (req, res) => res.write(req.body['name']));
    router.post('/home', (req, res) => res.write(req.body['name']));
    final res = await _dio.post('/home', options: Options(contentType: 'multipart/form-data'), data: {'name': 'queen'});
    expect(res.data, equals('queen'));
  });
}
