import 'dart:async';
import 'dart:mirrors';

import 'package:palace/palace.dart';
import 'package:palace/src/decorators/handler_param.dart';
import 'package:palace/utils/dto/dto_builder.dart';
import 'package:palace/utils/dto/dto_validator.dart';

/// takes a handler in the main pipe queue
/// invoke the handler its parameters base on types and decoration
Future<void> chiefHandler(
  Request req,
  Response res,
  Function call,
  Function? next,
) async {
  final callInstanceMirror = reflect(call);

  /// them handler method mirror
  final callClosureMirror = callInstanceMirror.getField(#call) as ClosureMirror;

  /// the list of the parameters that will be sent to the handler
  final callParamValues = [];

  /// for each parameter in the handlers parameters
  /// extract the value and add it to the pervious list
  for (final param in callClosureMirror.function.parameters) {
    callParamValues.add(_getParam(param, req, res, next));
  }

  /// invoke the handler and give it its parameters
  return callInstanceMirror.invoke(#call, callParamValues).reflectee;
}

/// extract the param value based on type or decorators
dynamic _getParam(
  ParameterMirror param,
  Request req,
  Response res,
  Function? next,
) {
  /// `Request` does not need to decorate with any thing the type is good enough
  if (param.type.reflectedType.toString() == 'Request') {
    return req;

    /// `Response` does not need to decorate with any thing the type is good enough
  } else if (param.type.reflectedType.toString() == 'Response') {
    return res;

    /// if the parameter is not decorated and is not Request or response
    ///  then extract the value based on the decoration
  } else if (param.metadata.isNotEmpty) {
    final deco =
        param.metadata.firstWhere((e) => e.reflectee is PalaceParamDecorator);
    if (deco.reflectee is Body) {
      return _getDecoratorValue(
          deco.reflectee, req.body, param.type.reflectedType);
    } else if (deco.reflectee is Next) {
      return _buildNext(next);
    } else if (deco is Query) {
      return _getDecoratorValue(
          deco.reflectee, req.queryParams, param.type.reflectedType);
    } else if (deco is Param) {
      return _getDecoratorValue(
          deco.reflectee, req.params, param.type.reflectedType);
    } else {
      throw '''
      [palace] you have extra param  with unknown type or decorator ${MirrorSystem.getName(deco.type.simpleName)} remove it or decorate it
      the supported type are : Request and Response
      the supported decorators for the controller functions are 
      Body() Param() Query() Next()
      ''';
    }
  } else {
    throw '''
      [palace] you have extra param ${MirrorSystem.getName(param.type.simpleName)} remove it or decorate it
      ''';
  }
}

dynamic _getDecoratorValue(OneKeyDecorator decorator, dynamic data, Type type) {
  if (decorator.key.isEmpty) {
    // hew wants the entire object
    var dto = reflectClass(type).newInstance(Symbol.empty, []);
    return validateDto(initDto(dto.reflectee, data));
  } else {
    /// he wants single field by key
    return data[decorator.key];
  }
}

dynamic _buildNext(Function? next) {
  if (next == null) {
    throw '''
        [palace][handler] you have decorated the parameter next and you cant have it in the function params .
        [palace][info] Handlers can not have next callback since they are the last callback in the queue !
        ''';
  }
  return next;
}
