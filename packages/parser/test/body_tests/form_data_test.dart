import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:palace_body_parser/body_parser.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'dart:io';

void main() {
  // * http client
  Dio? dio;
  // * server url
  const url = 'http://localhost:3000/';
  // * http server
  HttpServer? server;

  setUp(
    () async {
      dio = Dio(BaseOptions(validateStatus: (_) => true));

      server = await HttpServer.bind('127.0.0.1', 3000);
      //  ? listen for the incoming requests
      server!.listen((req) async {
        final result = await parseIoReq(req);

        req.response.headers.add('content-type', 'application/json');

        req.response.write(jsonEncode(result.toMap()));

        req.response.close();
      });
    },
  );
  tearDown(
    () async {
      // * close the server
      await server?.close();
      dio = null;
      server = null;
    },
  );

  test('empty multipart', () async {
    final res = await dio!.post(
      url,
      data: {},
      options: Options(contentType: 'form-data'),
    );
    expect(res.data['body'], isA<Map>());
    expect(res.data['body'], equals({}));
  });
  test('multipart String', () async {
    final res = await dio!.post(
      url,
      data: {'key': 'value'},
      options: Options(contentType: 'form-data'),
    );
    expect(res.data['body'], isA<Map>());
    expect(res.data['body'], equals({'key': 'value'}));
  });
}
