import 'package:palace/palace.dart';

// remove parsing the body functionally from the request in place it here
// it would be more clear
/// TODO: log the incoming requests in debug mode only within the console it self
class LogsGuard {
  void call(Request req, Response res, Function next) async {
    await next();
  }
}
