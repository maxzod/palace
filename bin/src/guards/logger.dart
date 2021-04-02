import '../../utils/config_reader.dart';
import '../http/request.dart';
import '../http/response.dart';

void loggerGuard(Request req, Response res) {
  final enableLog = !config<bool>('production');
  if (enableLog) {
    print('''
    At : ${DateTime.now().toIso8601String()} the palace had a visitor {
    method: ${req.method}
    path : ${req.uri.path}
    ip : ${req.connectionInfo!.remoteAddress}
    }
    ''');
  }
}
