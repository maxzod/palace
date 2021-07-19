import 'package:palace/palace.dart';

Future<void> main(List<String> args) async {
  final palace = Palace();
  palace.get('/', (req, res) => 'Long Live The Queen 👑');
  palace.post('/login', (req, res) {
    return req.body;
  });
  return palace.openGates();
}
