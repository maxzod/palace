import 'package:palace/palace.dart';

void main(List<String> args) async {
  final palace = Palace();
  palace.use(CorsGuard());
  palace.all('/', (req, res) => null);
  await palace.openGates();
}
