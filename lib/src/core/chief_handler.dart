import 'dart:mirrors';

import 'package:palace/palace.dart';
import 'package:palace/src/decorators/handler_param.dart';
import 'package:palace/utils/dto/dto_validator.dart';

// TODO MAKE SUER DOES NOT HAVE NAMED
// TODO MAKE SUER DOES NOT HAVE POSITIONAL
// TODO MAKE SUER DOES NOT HAVE UNDECORATED PARAMS
// TODO MAKE SUER DOES NOT HAVE MORE THAN ONE DECORATOR
void chiefHandler(
  Request req,
  Response res,
  Function call,
  Function? next,
) {
  final callMirror = reflect(call).getField(#call) as ClosureMirror;

  // final callMirror = reflectType(call.runtimeType) as FunctionTypeMirror;
  //  TODO :: PARAM AND BODY AND QUERY may contain one value check if keyword is not empty
  final callParamValues = [];
  // print(callMirror.parameters);
  for (final param in callMirror.function.parameters) {
    callParamValues.add(_getParam(param, req, res, call, next));
  }
  final callInstanceMirror = reflect(call);
  print('before');
  callInstanceMirror.invoke(#call, callParamValues);
  print('after');
}

dynamic _getParam(
  ParameterMirror param,
  Request req,
  Response res,
  Function call,
  Function? next,
) {
  if (param.type.isSubtypeOf(reflectClass(Request))) return req;
  if (param.type.isSubtypeOf(reflectClass(Response))) return res;
  if (param.metadata.isNotEmpty) {
    final deco = param.metadata.firstWhere((e) => e.reflectee is PalaceParamDecorator);
    if (deco.reflectee is Body) {
      return validateDto(req.body, dto: deco.reflectee);
    } else if (deco.reflectee is Next) {
      if (next == null) {
        throw '''
        [palace][handler] you have decorated the parameter next and you cant have it in the function params
        handlers can not have next callback since they are the last callback in the queue !
        ''';
      }
      return next;
    } else if (deco is Query) {
      return validateDto(req.queryParams, dto: deco.reflectee);
    } else if (deco is Param) {
      return validateDto(req.params, dto: deco.reflectee);
    } else {
      print(param.metadata.length);
      throw '''
      [palace] you have extra param
      ''';
    }
  }
}
