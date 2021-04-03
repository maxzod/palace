import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:palace/palace.dart';
import 'package:test/test.dart';

void main() {
  /// TODO : TEST SutUp and tearDown
  /// for some reason they doesn't work at all

  // late Palace router;

  // setUp(() async {
  //   router = Palace();
  //   await router.openGates();
  // });
  // tearDown(() async {
  //   await router.closeGates();
  // });
// open the server
  late Palace router;

  setUp(() async {
    router = Palace();
    await router.openGates();
  });
  tearDown(() async {
    await router.closeGates();
  });

  // set up server and routers ;
  //
  // * create new palace router
  //* set up routes for the test
  router.get('/', (req, res) => res.write('hello world'));
  router.get('/users/:id', (req, res) => res.write(req.params['id']));
  router.get('/users/:userId/tweets/:tweetId', (req, res) {
    final String userId = req.params['userId'];
    final String tweetId = req.params['tweetId'];
    return res.write('user id :$userId, tweet id :$tweetId');
  });
  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000', followRedirects: true, validateStatus: (_) => true));
  test('home route', () async {
    final response = await _dio.get('/');
    expect(response.statusCode, HttpStatus.ok);
  });
  test('match path with one param', () async {
    final response = await _dio.get('/users/66');
    expect(response.statusCode, HttpStatus.ok);
    expect(response.data, '66');
  });
  test('match path with tow params', () async {
    final response = await _dio.get('/users/66/tweets/99');
    expect(response.statusCode, HttpStatus.ok);
    expect(response.data, 'user id :66, tweet id :99');
  });

// open the server
  router.notFoundHandler = (req, res) => res.notFound(data: 'custom not found handler msg');
  // * create new palace router
  //* set up routes for the test
  router.get('/', (req, res) => res.write('hello world'));
  router.get('/users/:id', (req, res) => res.write('/users/:id'));
  router.get('/users/:id/sub', (req, res) => res.write('/users/:id/sub'));

  /// ? the tests
  test('custom not found', () async {
    final res = await _dio.get('/some_unknown_place');
    expect(res.statusCode, HttpStatus.notFound);
    expect(res.data, equals({'status_code': 404, 'message': 'Not found', 'data': 'custom not found handler msg'}));
  });
  test('home route', () async {
    final response = await _dio.get('/');
    expect(response.statusCode, HttpStatus.ok);
  });
  test('match with one segment', () async {
    final response = await _dio.get('/users/66');
    expect(response.data, '66');
  });
  test('match path with tow segments', () async {
    final response = await _dio.get('/users/66/sub');
    expect(response.statusCode, HttpStatus.ok);
    expect(response.data, '/users/:id/sub');
  });
}
