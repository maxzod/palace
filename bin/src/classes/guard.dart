import 'package:meta/meta.dart';

import 'req.dart';
import 'res.dart';

/// ?  `PalaceGuard
/// * can work as middleware
/// * can work as auth-guard
/// ? for example logger , authentication , authorization, what every you need :D  ,
/// if you want to stop  execution `throw` `exception`  or better respond with any thing you want
@immutable
abstract class PalaceGuard {
  Future<void> handleBefore(Request req, Response res);

  // TODO :: handle after
  // Future<void> handleAfter(Request req, Response res);
}
