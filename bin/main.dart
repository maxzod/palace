import 'package:palace/palace.dart';
import 'package:palace/src/guards/static_file_guard.dart';

void main(List<String> args) async {
  final palace = Palace();
  palace.use(PublicFilesGuard());
  palace.all('/', (req, res) => null);
  await palace.openGates();
}
