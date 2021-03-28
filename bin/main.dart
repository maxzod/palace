import 'classes/palace.dart';
import 'guards/logger.dart';
import 'router.dart';

Future<void> main(List<String> args) async {
  final router = PalaceRouter();
  router.use(LoggerGuard());
  router.get('/users', (req) async {
    return {
      "1": {"name": "ahmed"},
      "2": {"name": "ahmed"},
    };
  });
  router.get('/internal/error', (req) async {
    int? x;
    final y = x! * 6;
    return y;
  });
  openGates(router);
}
