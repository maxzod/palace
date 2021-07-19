import 'package:palace/palace.dart';

Future<void> main(List<String> args) async {
  final palace = Palace();
  palace.get('/', (req, res) => 'Long Live The Queen 👑');
  palace.get('/login', (req, res) {
    return NotFound();
  });
  return palace.openGates();
}
