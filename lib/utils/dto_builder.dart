import 'dart:convert';
import 'dart:mirrors';

import 'package:palace/palace.dart';

T buildDto<T>(Object body) {
  try {
    var _body = body is String ? jsonDecode(body) : body;
    final dtoClassRef = reflectClass(T);
    final dtoMirror = dtoClassRef.newInstance(Symbol.empty, []);
    final fields =
        dtoMirror.type.declarations.values.whereType<VariableMirror>();
    _body as Map<String, dynamic>;

    /// ! throws LateInitializationError
    // for (final key in _body.keys) {
    //   if (fields.where((f) => key == MirrorSystem.getName(f.simpleName)).isNotEmpty) {
    //     dtoMirror.setField(Symbol(key), _body[key]);
    //   }
    // }
    for (final field in fields) {
      final fieldName = _extractSymbolName(field.simpleName);
      dtoMirror.setField(field.simpleName, _body[fieldName]);
    }

    return dtoMirror.reflectee as T;
  } catch (e) {
    throw BadRequest(data: 'body is not acceptable try to change the format');
  }
}

String _extractSymbolName(Symbol symbol) {
  /// TODO :: there is a better way but i don't remember it
  return symbol.toString().replaceAll('Symbol("', '').replaceAll('")', '');
}
