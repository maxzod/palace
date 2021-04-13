import 'package:palace/palace.dart';
import 'package:palace/src/decorators/handler_param.dart';
import 'package:palace/src/decorators/http_method.dart';
import 'package:palace/src/types.dart';
import 'package:palace_validators/palace_validators.dart';

void main(List<String> args) async {
  final palace = Palace();
  // palace.use(CorsGuard());
  palace.controllers([UsersController()]);
  await palace.openGates();
}

class UsersController extends PalaceController {
  UsersController() : super('/users');

  @Get()
  void getOne(Request req, Response res, @Body('id') String? id) async {
    print('this will be called when GET => /users');
    res.json({
      'data': ['a', 'b', 'c', 'd', id]
    });
  }

  @Post()
  void PostOne(Response res, @Body() SignUpDto body) {
    return res.send('email :${body.email} , password:${body.password}');
  }
}

class SignUpDto {
  @IsEmail()
  late String email;

  @MinLength(5)
  late String password;
}
