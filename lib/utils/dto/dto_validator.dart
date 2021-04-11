import 'package:palace/utils/dto/dto_builder.dart';
import 'package:palace_validators/dto_validator.dart' as palace_validators;

import '../../palace.dart';

/// ! `throw BadRequest exception`
dynamic validateDto<T>(Map<String, dynamic> body, {Object? dto}) {
  /// build dto from the request body
  final _dto = dto ?? buildDto<T>(body);

  /// validate the dto
  final errs = palace_validators.validateDto(_dto as Object);

  /// in case of any failure throw exception
  if (errs.isNotEmpty) {
    throw BadRequest(data: errs);
  }

  /// else every thing is fine return the dto
  return _dto as dynamic;
}
