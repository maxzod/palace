import 'package:palace/palace.dart';
import 'package:palace/src/decorators/http_method.dart';
import 'package:palace/src/types.dart';
import 'package:palace_validators/palace_validators.dart';

void main(List<String> args) async {
  final palace = Palace();
  palace.use(CorsGuard());
  palace.controllers([UsersController()]);
  await palace.openGates();
}

class UsersController extends PalaceController {
  UsersController() : super('/users');

  @Get()
  void getOne(Request req, Response res) async {
    print('this will be called when GET => /users');
    res.json({
      'data': ['a', 'b', 'c', 'd']
    });
  }

  @Post()
  void PostOne(Response res) {
    res.json({'data': 'Sent'});
  }
}

class SignUpDto {
  @IsEmail()
  late String email;

  @MinLength(5)
  late String password;
}
