import 'package:palace/palace.dart';

Future<void> main(List<String> arguments) async {
  final palace = Palace();
  palace.get('/', (req, res) => res.write('Long Live The Queen ! 👑'));
  palace.get('/profile', (req, res) => res.write('some price profile'));
  palace.post(
      '/signup',
      (req, res) =>
          res.write('you have called sign up endpoint with post method '));
  palace.all(
      '/about',
      (req, res) => res.write(
            '''you have called about endpoint with ${req.method} method
               but it will be trigger with any type of method''',
          ));

  await palace.openGates();
}
