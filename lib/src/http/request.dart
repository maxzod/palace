import 'dart:io' as io;

import 'package:palace/src/exceptions/bad_request.dart';
import 'package:palace/utils/dto_builder.dart';
import 'package:path_to_regexp/path_to_regexp.dart';
import 'package:palace_validators/palace_validators.dart';
import 'package:palace/palace.dart';

///* contains simplified logic to extract data from the io req class
class Request {
  final io.HttpRequest request;

  static Future<Request> init(io.HttpRequest request, EndPoint endPoint) async {
    ///* set up request path params
    final _pathParams = <String>[];
    final _pathRegx = pathToRegExp(endPoint.path, parameters: _pathParams);
    final match = _pathRegx.matchAsPrefix(request.uri.path);

    var _routeParams = <String, String>{};
    if (match != null) _routeParams = extract(_pathParams, match);

    return Request._(
      request: request,
      params: _routeParams,

      ///* set up request query params
      queryParams: request.uri.queryParameters,
    );
  }

  Request._({
    required this.request,
    required this.params,
    required this.queryParams,
  });

  dynamic? _body;

  set body(b) => _body = b;

  /// the request body
  Map<String?, dynamic> get body => _body ?? request.uri.data;

  /// ? getter part
  late Map<String, dynamic> params;

  /// the query parameters from the incoming request
  Map<String, dynamic> queryParams;

  /// the HttpRequest instance

  /// the HttpHeaders instance from the request
  io.HttpHeaders get headers => request.headers;

  /// the request method
  String get method => request.method;

  /// return the the request path
  String get path => request.uri.path;

  /// return the httpSession from the io request
  io.HttpSession get session => request.session;

  /// return the cookies from the io request=
  List<io.Cookie> get cookies => request.cookies;

  /// to validate the wit dto
  /// ! `throw BadRequest exception`
  T validate<T>() {
    /// build dto from the request body
    final dto = buildDto<T>(body);

    /// validate the dto
    final errs = validateDto(dto as Object);

    /// in case of any failure throw exception
    if (errs.isNotEmpty) {
      throw BadRequest(data: errs);
    }

    /// else every thing is fine return the dto
    return dto;
  }
}
