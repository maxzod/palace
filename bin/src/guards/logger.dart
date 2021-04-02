import '../../utils/config_reader.dart';
import '../http/request.dart';
import '../http/response/response.dart';

Future<void> loggerGuard(Request req, Response res) async {
  final enableLog = !config<bool>('production');

  if (enableLog) {
    print(req.request.uri.path);
    await res.file('somepath/somefile.someext');
    await res.json({'data': req.queryParams});
  }
}
// ip : ${req.connectionInfo!.remoteAddress}
