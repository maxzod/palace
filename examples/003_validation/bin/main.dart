import 'package:palace/palace.dart';

import 'package:palace_validators/palace_validators.dart';

class SignInDto {
  @IsEmail()
  late String email;
  @MinLength(6)
  late String password;
}

Future<void> main(List<String> arguments) async {
  /// * you can run as any normal dart app
  /// ? or user the light house to run and watch for changes  'package:lighthouse'

  final palace = Palace();
  palace.get('/', (req, res) => res.write('Long Live The Queen !'));
  palace.post('/auth/sign_in', (req, res) async {
    /// ! will throw bad request exception
    /// * but the palace will catch it and reopened with 400 status code and display
    /// * the failure on validation rules on it
    final dto = req.validate<SignInDto>();
    await res.write('email :${dto.email} , password:${dto.password}');
  });

  await palace.openGates();
}
