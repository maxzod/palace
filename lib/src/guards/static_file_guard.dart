import 'package:palace/palace.dart';

///
class StaticGuard {
  final String path;

  StaticGuard({this.path = 'public'});
  void call(Request req, Response res, next) async {
    // TODO :: STATIC GUARD
  }
}
