// import 'dart:io';

// import 'package:dio/dio.dart' hide Response;
// import 'package:palace/palace.dart';
// import 'package:palace/src/decorators/handler_param.dart';
// import 'package:palace/src/decorators/http_method.dart';
// import 'package:palace/src/types.dart';
// import 'package:palace_validators/palace_validators.dart';
// import 'package:test/test.dart';

// void main() {
//   late Palace router;

//   final _dio =
//       Dio(BaseOptions(baseUrl: 'http://localhost:3000', followRedirects: true, validateStatus: (_) => true, contentType: 'application/json'));

//   setUp(() async {
//     router = Palace();
//     router.controllers([Controller()]);

//     await router.openGates();
//   });
//   tearDown(() async {
//     await router.closeGates();
//   });

//   test('not valid dto ', () async {
//     final inValidReqRes = await _dio.post('/auth/not_valid_dto', data: {'email': 'queenpalace.kingdom', 'password': '123'});
//     expect(inValidReqRes.statusCode, equals(HttpStatus.badRequest));
//     expect(
//       inValidReqRes.data,
//       equals({
//         'status_code': 400,
//         'message': 'Bad Request',
//         'data': [
//           'email is not valid email address',
//           'password min length is 6',
//         ]
//       }),
//     );
//   });

//   test('valid dto ', () async {
//     final validReqRes = await _dio.post('/auth/valid_dto', data: {'email': 'queen@palace.kingdom', 'password': 'to_kingdom_secret'});
//     expect(validReqRes.data, equals('email :queen@palace.kingdom , password:to_kingdom_secret'));
//   });
//   test('IsOptionalDto validation ', () async {
//     final validReqRes = await _dio.post('/auth/IsOptionalDto', data: {'email': 'queen@palace.kingdom', 'password': 'to_kingdom_secret'});
//     expect(validReqRes.data, equals('email :queen@palace.kingdom , password:to_kingdom_secret'));
//   });
// }

// // covariant
// class Controller extends PalaceController {
//   Controller() : super('/auth');

//   @Post('/not_valid_dto')
//   void notValidDto(Request req, Response res, @Body() SignInDto body) async {
//     res.send('email :${body.email} , password:${body.password}');
//   }

//   @Post('/valid_dto')
//   void validDto(Request req, Response res, @Body() SignInDto body) async {
//     res.send('email :${body.email} , password:${body.password}');
//   }

//   @Post('/IsOptionalDto')
//   void signUp(Request req, Response res, @Body() SignInDto body) async {
//     res.send('email :${body.email} , password:${body.password}');
//   }
// }

// class SignInDto {
//   @IsEmail()
//   String? email;
//   @MinLength(6)
//   String? password;
// }

// class IsOptionalDto {
//   @IsEmail()
//   String? email;
//   @MinLength(6)
//   String? password;

//   @IsOptional()
//   @MinLength(50)
//   String? fcmToken;
// }
