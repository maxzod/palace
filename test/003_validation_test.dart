import 'dart:io';

import 'package:dio/dio.dart';
import 'package:palace/palace.dart';
import 'package:palace_validators/palace_validators.dart';
import 'package:test/test.dart';

void main() {
  late Palace router;

  final _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:3000',
    followRedirects: true,
    validateStatus: (_) => true,
    contentType: ContentType.json.toString(),
  ));

  setUp(() async {
    router = Palace();
    await router.openGates();
  });
  tearDown(() async {
    await router.closeGates();
  });

  test('dato validation ', () async {
    router.use(BodyParser());

    router.post('/auth/sign_in', (req, res) async {
      final dto = req.validate<SignInDto>();
      await res.write('email :${dto.email} , password:${dto.password}');
    });

    final inValidReqRes = await _dio.post('/auth/sign_in', data: {'email': 'queenpalace.kingdom', 'password': '123'});
    expect(inValidReqRes.statusCode, equals(HttpStatus.badRequest));
    expect(
        inValidReqRes.data,
        equals({
          'status_code': 400,
          'message': 'Bad Request',
          'data': ['email is not valid email address', 'password min length is 6']
        }));

    final validReqRes = await _dio.post('/auth/sign_in', data: {'email': 'queen@palace.kingdom', 'password': 'to_kingdom_secret'});

    expect(validReqRes.data, equals('email :queen@palace.kingdom , password:to_kingdom_secret'));
  });
}

class SignInDto {
  @IsEmail()
  late String email;
  @MinLength(6)
  late String password;
}
