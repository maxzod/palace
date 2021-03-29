import '../classes/guard.dart';
import '../classes/req.dart';
import '../classes/res.dart';

class LoggerGuard extends PalaceGuard {
  @override
  Future<void> handleBefore(Request req, Response res) async {
    print('''
    At : ${DateTime.now().toIso8601String()} the palace had a visitor {
    method: ${req.method}
    path : ${req.uri.path}
    ip : ${req.connectionInfo!.remoteAddress}
    }
    ''');
  }
}
