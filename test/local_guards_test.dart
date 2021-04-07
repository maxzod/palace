import 'dart:io';

import 'package:dio/dio.dart';
import 'package:palace/palace.dart';
import 'package:test/test.dart';

void main() {
  late Palace router;

  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000', followRedirects: true, validateStatus: (_) => true));

  setUp(() async {
    router = Palace();
    await router.openGates();
  });
  tearDown(() async {
    await router.closeGates();
  });
  test('one guard', () async {
    router.get('/', (req, res) {
      res.send('ahmed');
      print(req.body);
    }, guards: [
      (req, res, next) {
        print('help');
        req.body['ahmed'] = 'aa';
        next();
      },
    ]);

    final response = await _dio.get('/');
    print(response.data);
    expect(response.statusCode, HttpStatus.ok);
    expect(response.data.toString(), equals('ahmed'));
  });
}
