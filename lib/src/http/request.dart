import 'dart:io' as io;

import 'package:http_server/http_server.dart';
import 'package:path_to_regexp/path_to_regexp.dart';

import '../router/endpoint.dart';

///* contains simplified logic to extract data from the io req class
class Request {
  final io.HttpRequest request;

  static Future<Request> init(io.HttpRequest request, EndPoint endPoint) async {
    /// *set up request body
    final _body = await HttpBodyHandler.processRequest(request);

    ///* set up request path params
    final _pathParams = <String>[];
    final _pathRegx = pathToRegExp(endPoint.path, parameters: _pathParams);
    final match = _pathRegx.matchAsPrefix(request.uri.path);
    var _routerParams = <String, String>{};
    if (match != null) _routerParams = extract(_pathParams, match);

    ///* set up request query params
    return Request._(
      request: request,
      bodyType: _body.type,
      body: _body.body,
      params: _routerParams,
      queryParams: request.uri.queryParameters,
    );
  }

  Request._({
    required this.request,
    required this.body,
    required this.bodyType,
    required this.params,
    required this.queryParams,
  });

  dynamic body;
  String bodyType;

// ********************************
  /// ? getter part
  late Map<String, dynamic> params;
  late Map<String, dynamic> queryParams;

  io.HttpRequest get ioRequest => request;

  List<io.Cookie> get cookies => ioRequest.cookies;

  io.HttpHeaders get headers => ioRequest.headers;

  Uri get uri => ioRequest.uri;

  String get method => request.method;
  @override
  String toString() {
    return '''
    At : ${DateTime.now().toIso8601String()} the palace had a visitor {
    method: $method
    cookies: $cookies
    params: $params
    path : ${uri.path}
    
    }
    ''';
  }
}
/*
body : ${ioRequest.uri.data?.parameters}
    body : ${ioRequest.requestedUri.data?.parameters}
    body : ${ioRequest.requestedUri.queryParametersAll}
    body : ${ioRequest.certificate}
    body : ${ioRequest.connectionInfo}
    body : ${ioRequest.contentLength}
    body : ${ioRequest.cookies}
    body : ${ioRequest.headers}
    body : ${ioRequest.persistentConnection}
    body : ${ioRequest.protocolVersion}
    body : ${ioRequest.requestedUri}
    body : ${ioRequest.session}
    body : ${ioRequest.uri}
    body : ${ioRequest.first}
    body : ${ioRequest.isBroadcast}
    body : ${ioRequest.last}
    
     */
