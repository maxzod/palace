import 'dart:mirrors';

import 'package:palace/palace.dart';
import 'package:palace_validators/palace_validators.dart';

T buildDto<T>(dynamic body) {
  try {
    final dtoClassRef = reflectClass(T);
    final dtoMirror = dtoClassRef.newInstance(Symbol.empty, []);

    /// list of dto variables mirrors
    final fields =
        dtoMirror.type.declarations.values.whereType<VariableMirror>();

    /// ! throws LateInitializationError
    // for (final key in _body.keys) {
    //   if (fields.where((f) => key == MirrorSystem.getName(f.simpleName)).isNotEmpty) {
    //     dtoMirror.setField(Symbol(key), _body[key]);
    //   }
    // }
    /// lop for each field try to add a value to it
    for (final field in fields) {
      print(field.type.reflectedType);
      final fieldName = _extractSymbolName(field.simpleName);
      try {
        /// by default the body contains strings
        var value = body[fieldName];

        /// convert a string to bool when is could bee and the variable type is also bool
        if (value.runtimeType != field.type.reflectedType &&
            field.type.reflectedType == bool &&
            isBoolean(value)) {
          value = _convertToBool(value);

          ///same fo double
        } else if (value.runtimeType != field.type.reflectedType &&
            field.type.reflectedType == double) {
          value = _convertToDouble(value);

          /// same for int
        } else if (value.runtimeType != field.type.reflectedType &&
            field.type.reflectedType == int) {
          value = _convertToInt(value);
        }
        dtoMirror.setField(field.simpleName, value);
      } on TypeError {
        final rightType = field.type.reflectedType;
        throw BadRequest(data: '$fieldName must be $rightType');
      }
    }

    return dtoMirror.reflectee as T;
  } on BadRequest {
    rethrow;
  } catch (e) {
    throw BadRequest(data: 'body is not acceptable try to change the format');
  }
}

String _extractSymbolName(Symbol symbol) {
  /// TODO :: there is a better way but i don't remember it
  return symbol.toString().replaceAll('Symbol("', '').replaceAll('")', '');
}

bool _convertToBool(String value) {
  return value == 'true' || value == 'True' || value == '1' || value == '1.0';
}

dynamic _convertToDouble(String value) {
  try {
    return double.parse(value);
  } catch (e) {
    return value;
  }
}

dynamic _convertToInt(String value) {
  try {
    return int.parse(value);
  } catch (e) {
    return value;
  }
}
