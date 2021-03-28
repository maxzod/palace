import '../classes/guard.dart';
import '../classes/req.dart';
import '../classes/res.dart';

class LoggerGuard extends PalaceGuard {
  @override
  Future<Res?> handle(Request req) async {
    print(
        'at ${DateTime.now().toIso8601String()} the palace had a visitor which was going to ');
    print('${req.method}  ${req.uri.path}');
  }
}
