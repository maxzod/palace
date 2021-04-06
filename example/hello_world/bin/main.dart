import 'package:palace/palace.dart';

Future<void> main(List<String> arguments) async {
  final palace = Palace();

  palace.get(
    '/',
    (req, res) => res.json('Long Live The Queen !'),
  );

  await palace.openGates();
}
