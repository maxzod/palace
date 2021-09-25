//* covert String to accutal Type
import 'dart:convert';

/// takes input as `String`
/// parse the input to `acctual` type
dynamic convertStringToAcctualType(String value) {
  // TODO :: boolean (queen_validators)
  // TODO :: to num int , double
  try {
    var numValue = num.parse(value);

    if (!numValue.isNaN) {
      return numValue;
    } else {
      return value;
    }
  } on FormatException {
    final isList = value.startsWith('[') && value.endsWith(']');
    if (isList) {
      return extractTheActturalTypeOfAList(value);
    } else if (value.startsWith('{') && value.endsWith('}')) {
      // is Map
      //* its a Map
      // TODO :: TODO :(bug) it might be a set
      final result = jsonDecode(value);
      return result;
    } else if (value.trim().toLowerCase() == 'null') {
      // * is null string
      return null;
    } else {
      return value;
    }
  }
}

List extractTheActturalTypeOfAList(String listAsString) {
  // return [listAsString];
  final result = listAsString
      .substring(0)
      .substring(0, listAsString.length - 1)
      .split(',');
  return result;
}
