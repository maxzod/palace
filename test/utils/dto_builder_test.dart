import 'package:palace/palace.dart';
import 'package:palace/utils/dto/dto_builder.dart';
import 'package:test/test.dart';

void main() {
  test('invalid body format', () async {
    try {
      final body = 'string as body';
      buildDto(body);
    } on BadRequest catch (e) {
      expect(e.data, equals(['body is not acceptable try to change the format']));
    }
  });
  test('invalid body with NULL values', () async {
    try {
      final body = {'name': 'ahmed'};
      buildDto<SimpleDto2>(body);
    } catch (e) {
      expect(e, isA<BadRequest>());
    }
  });
  test('valid body', () async {
    try {
      final body = {'name': 'ahmed'};
      final dto = buildDto<SimpleDto>(body);
      expect(dto.name, equals('ahmed'));
    } on BadRequest catch (e) {
      print(e.data);
    }
  });
  test('nullable values', () async {
    try {
      final body = {'name': 'ahmed'};
      final dto = buildDto<NullAbleDto>(body);
      expect(dto.name, equals('ahmed'));
      expect(dto.email, equals(null));
    } on BadRequest catch (e) {
      print(e.data);
    }
  });
}

class SimpleDto {
  late String name;
}

class SimpleDto2 {
  late String? name;

  late String? email;
}

class NullAbleDto {
  late String name;

  String? email;
}
