import 'dart:convert';
import 'dart:io' as io;
import 'package:meta/meta.dart';

/// * contains getters and logic to respond to incoming req
///
///

extension on Response {
  String toJson(Object data) {
    return data is String ? data : jsonEncode(data);
  }

  int get defStatusCode {
    final _method = _request.method.toUpperCase();
    if (_method == 'GET') {
      return io.HttpStatus.ok;
    } else if (_method == 'POST') {
      return io.HttpStatus.created;
    }
    // TODO THE rest;
    return io.HttpStatus.badRequest;
  }
}

class Response {
  /// * response class
  /// * you `can` build from built in factories
  ////  create one from scratch  ? i don't think you might want to that but here if you want so.
  /// * in case of returning just plain Object
  /// * the framework will create one for you based on the collected data form you returned data and the Request
  /// * for example :-
  /// * GET => /users  and you returned Json object
  /// * so the response statusCode = StatusCode.ok and the contentType = ContentType.json  and so on ....
  var _isClosed = false;
  bool get isClosed => _isClosed;

  final int? statusCode;
  final io.ContentType? contentType;

  late final io.HttpResponse _response;

  late final io.HttpRequest _request;

  Response(
    io.HttpRequest req, {
    this.statusCode,
    this.contentType,
  }) {
    _request = req;
    _response = req.response;
  }
  // factory init(io.HttpResponse response) {
  //   return Request(response);
  // }

  Response? copyWith() {}

  // d
  // will send the data converted to json
  // if no statusCode was provided it will will set the status code to the defaultCode based on the request;
  Future<void> json(
    Object data, {
    int? statusCode,
  }) async {
    /// set the Response contentType to Json
    _response.headers.contentType = io.ContentType.json;
    // set the default status code
    _response.statusCode = statusCode ?? defStatusCode;

    /// append the data to the response
    await write(toJson(data));
  }

  @protected
  Future<void> write(Object data) async {
    _isClosed = true;
    _response.write(data);
  }

  // will send the data converted to json
  // if no statusCode was provided it will will set the status code to the defaultCode based on the request;
  Future<void> notFound({
    Object? data,
  }) async {
    /// set the Response contentType to Json
    _response.headers.contentType = io.ContentType.json;

    _response.statusCode = io.HttpStatus.notFound;

    /// append the data to the response
    _response.write(toJson(
      data ??
          {
            'status_code': io.HttpStatus.notFound,
            'message': 'Not found',
          },
    ));
  }

  // d
  // will send the data converted to json
  // if no statusCode was provided it will will set the status code to the defaultCode based on the request;
  Future<void> internalServerError({
    Object? data,
  }) async {
    /// set the Response contentType to Json
    _response.headers.contentType = io.ContentType.json;

    _response.statusCode = io.HttpStatus.notFound;

    /// append the data to the response
    _response.write(toJson(
      // TODO :: disable showing exceptions in production mode
      // data != null && isDebugMode ? data :
      data ??
          {
            'status_code': io.HttpStatus.internalServerError,
            'message': 'Internal Server Error',
          },
    ));
  }
}
