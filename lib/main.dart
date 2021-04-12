// void main(List<String> args) async {
//   // chiefHandler(test);
// }

// class Body {
//   const Body();
// }

// void test() {
//   print('x x');
//   print('y y');
//   print('z z');
// }

import 'package:palace/palace.dart';
import 'package:palace/src/decorators/http_method.dart';
import 'package:palace/src/decorators/use_guard.dart';
import 'package:palace/src/types.dart';
import 'package:palace_validators/palace_validators.dart';

void main(List<String> args) async {
  final palace = Palace();
  palace.controllers([
    UsersController(),
  ]);
  await palace.openGates();
}

class UsersController extends PalaceController {
  UsersController() : super('/users');

  // @Post()
  // void findOne(Request req, Response res, @Body() SignUpDto body) {
  //   print('this will be called when POST => /users');
  // }
  @UseGuard(CorsGuard())
  @Get()

  
  // @UseGuard(LogsGuard())
  void deleteOne(Request req, Response res) {
    print('this will be called when GET => /users');
    res.json('data');
  }

  @UseGuard(CorsGuard())
  @Post()
  void ddd(Request req, Response res) {
    //anything can work unless he doesn't serve any response
    res.json({'data': 'Sent'});
    // any other res/req handling after this wont work
  }
}

class SignUpDto {
  @IsEmail()
  late String email;

  @MinLength(5)
  late String password;
}
// void test(){
// palace.use(PublicFilesGuard());
//   await PalaceDB.init();
//   final db = PalaceDB.i;
//   try {
//     await db.query('DROP TABLE `users`');
//     print('db dropped ❌');
//   } catch (e) {}
//   await db.query('''
//   CREATE TABLE `users`
//   (
//     `id` INTEGER,
//     `email` VARCHAR(255),
//     `createdAt` TIMESTAMP

// );

// //   ''');
// //   await db.query('INSERT INTO `users`   (`id`,`email`,`createdAt`) VALUES (1 , "sss" , ?) ', [DateTime.now().toUtc()]);

// //   // 'createdAt` DATETIME()

// //   print('db created !');
//   palace.all('/', (req, res) async {
//     final db = PalaceDB.i;
//     final result = await db.query('SELECT * FROM `user` WHERE `id` = ? ', [req.body['id']]);
//     final data = result.first.fields;
//     return res.json(data);
//   });
//   await palace.openGates();
// }
// }
