import 'dart:mirrors';

import 'package:palace/palace.dart';
import 'package:palace_validators/palace_validators.dart';

Object initDto(Object dto, dynamic body) {
  /// new instance of the reflected class
  final dtoMirror = reflect(dto);

  /// list of dto variables mirrors
  final fields = dtoMirror.type.declarations.values.whereType<VariableMirror>();

  /// loop for each field try to add a value to it
  for (final field in fields) {
    /// name of the variable we are trying to give it a value from the body
    final fieldName = _extractSymbolName(field.simpleName);

    /// try and catch since the covert process might throw exception `TypeError`
    try {
      /// by default the body contains strings
      var value = body[fieldName];

      /// convert a string to bool when is could bee and the variable type is also bool
      if (value.runtimeType != field.type.reflectedType && field.type.reflectedType == bool && isBoolean(value)) {
        value = _convertToBool(value);

        ///same fo double
      } else if (value.runtimeType != field.type.reflectedType && field.type.reflectedType == double) {
        value = _convertToDouble(value);

        /// same for int
      } else if (value.runtimeType != field.type.reflectedType && field.type.reflectedType == int) {
        value = _convertToInt(value);
      }

      /// but the value of the value inside the right DTO instance
      dtoMirror.setField(field.simpleName, value);
    } on TypeError {
      /// so we have tried to but a value to variable but there types did not match
      /// like when you specify a dto variable as `bool` but the client side send you a `int`
      /// the palace will throw exception to tell the front side which type is wrong
      final rightType = field.type.reflectedType;

      /// will be caught by the main pipe inside the router class
      throw BadRequest(data: ['$fieldName must be $rightType']);
    }
  }
  return dtoMirror.reflectee;
}

T buildDto<T>(dynamic body) {
  try {
    /// reflection of the class
    final dtoClassRef = reflectClass(T);

    /// create new dto instance from generic type
    final dtoReflection = dtoClassRef.newInstance(Symbol.empty, []);

    final dto = initDto(dtoReflection.reflectee, body);

    return dto as T;
  } on BadRequest {
    rethrow;
  } catch (e) {
    print(e);
    throw BadRequest(data: ['body is not acceptable try to change the format']);
  }
}

/// takes Symbol('name') and returns 'name'
String _extractSymbolName(Symbol symbol) => MirrorSystem.getName(symbol);

/// the input might be `"true"` as boolean but becomes string when converting it to body of http request
/// so we need it back to beck Type of boolean
bool _convertToBool(String value) => value == 'true' || value == 'True' || value == '1' || value == '1.0';

/// the input might be `"1.5"` as rightful double but the process of http request convert it to string
/// so we need to convert it back to double
dynamic _convertToDouble(String value) => double.tryParse(value) ?? value;

/// the input might be `"1"` as rightful int but the process of http request convert it to string
/// so we need to convert it to back to int
dynamic _convertToInt(String value) => int.tryParse(value) ?? value;
