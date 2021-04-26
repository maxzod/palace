import 'package:palace_validators/dto_validator.dart' as palace_validators;

import '../../palace.dart';

/// ! `throw BadRequest exception`
Object validateDto(Object dto) {
  /// build dto from the request body
  final _dto = dto;

  /// validate the dto
  final errs = palace_validators.validateDto(_dto);

  /// in case of any failure throw exception
  if (errs.isNotEmpty) {
    throw BadRequest(errs);
  }

  /// else every thing is fine return the dto
  return _dto;
}

// Object buildAndValidateDto(Map<String, dynamic> body, Type t) {
//   final dto = buildDto(body, t);
//   return validateDto(dto);
// }
