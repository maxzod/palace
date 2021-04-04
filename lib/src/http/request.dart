import 'dart:io' as io;
import 'dart:mirrors';

import 'package:palace/src/exceptions/bad_request.dart';
import 'package:path_to_regexp/path_to_regexp.dart';
import 'package:palace_validators/palace_validators.dart';
import 'package:palace/palace.dart';

///* contains simplified logic to extract data from the io req class
class Request {
  final io.HttpRequest request;

  static Future<Request> init(io.HttpRequest request, EndPoint endPoint) async {
    /// * set up request body
    // final _body = await HttpBodyHandler.processRequest(request);

    ///* set up request path params
    final _pathParams = <String>[];
    final _pathRegx = pathToRegExp(endPoint.path, parameters: _pathParams);
    final match = _pathRegx.matchAsPrefix(request.uri.path);
    var _routerParams = <String, String>{};
    if (match != null) _routerParams = extract(_pathParams, match);

    ///* set up request query params
    return Request._(
      request: request,
      // bodyType: _body.type,
      // body: _body.body,
      params: _routerParams,
      queryParams: request.uri.queryParameters,
    );
  }

  Request._({
    required this.request,
    // required this.body,
    // required this.bodyType,
    required this.params,
    required this.queryParams,
  });

  dynamic? _body;
  String? _bodyType;

  set body(b) => _body = b;
  // TODO :: why body type setter conflict with the getter when i set type to string
  // set bodyType(String bodyType) => _bodyType = bodyType;
  set bodyType(bodyType) => _bodyType = bodyType;

  dynamic get body => _body ?? ioRequest.uri.data;
  String? get bodyType => _bodyType;

  /// ? getter part
  late Map<String, dynamic> params;
  late Map<String, dynamic> queryParams;

  io.HttpRequest get ioRequest => request;

  io.HttpHeaders get headers => ioRequest.headers;

  String get method => request.method;

  T validate<T>() {
    final dto = _buildDto<T>(body);
    final errs = validateDto(dto);
    if (errs.isNotEmpty) {
      throw BadRequest(data: errs);
    }
    return dto as T;
  }

  Object _buildDto<T>(Map<String, dynamic> body) {
    final dtoClassRef = reflectClass(T);
    final dtoMirror = dtoClassRef.newInstance(Symbol.empty, []);
    final fields = dtoMirror.type.declarations.values.whereType<VariableMirror>();
    for (final key in body.keys) {
      if (fields.where((f) => key == MirrorSystem.getName(f.simpleName)).isNotEmpty) {
        dtoMirror.setField(Symbol(key), body[key]);
      }
    }
    return dtoMirror.reflectee as Object;
  }
}
