import 'package:palace/palace.dart';
import 'package:palace/utils/dto_builder.dart';
import 'package:test/test.dart';

void main() {
  test('invalid body format', () async {
    try {
      final body = 'string as body';
      buildDto(body);
    } on BadRequest catch (e) {
      expect(e.data, equals('body is not acceptable try to change the format'));
    }
  });
  test('invalid body with NULL values', () async {
    final body = {'name': 'ahmed'};
    final dto = buildDto<SimpleDto2>(body);
    expect(dto.name, equals('ahmed'));
    expect(dto.email, null);
  });
  test('valid body', () async {
    final body = {'name': 'ahmed'};
    final dto = buildDto<SimpleDto>(body);
    expect(dto.name, equals('ahmed'));
  });
}

class SimpleDto {
  String? name;
}

class SimpleDto2 {
  String? name;
  String? email;
}
