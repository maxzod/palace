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

  test(
    'empty Map',
    () async {
      final res = await dio!.get(
        url,
        queryParameters: {'map': {}},
      );

      expect(res.data['map'], isA<Map>());
      expect(res.data['map'], equals({}));
    },
  );
  // test('embded Map', () async {
  //   final res = await dio!.get(
  //     url,
  //     queryParameters: {
  //       'map': {
  //         'inner_map': {
  //           'foo': 'bar',
  //         },
  //         'some_key': 'some_val',
  //       }
  //     },
  //   );

  //   expect(res.data['map'], isA<Map>());
  //   expect(res.data['map']['inner_map']['foo'], equals('bar'));
  //   expect(res.data['map']['some_key'], equals('some_val'));
  //   expect(
  //       res.data['map'],
  //       equals({
  //         'map': {
  //           'inner_map': {
  //             'foo': 'bar',
  //           },
  //         }
  //       }));
  // });
}
