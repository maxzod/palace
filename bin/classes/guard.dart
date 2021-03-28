import 'package:meta/meta.dart';

import 'req.dart';
import 'res.dart';

/// ?  `PalaceGuard
/// * can work as middleware
/// * can work as auth-guard
/// ? for example logger , authentication , authorization, what every you need :D  ,
/// if you want to stop  execution `throw` `exception` and the `framework`
/// will handle it format it and respond to req
/// `optionally` if you want you can `return` `response`
/// if else don't throw or return and the framework will run the next `guard` an so on
@immutable
abstract class PalaceGuard {
  Future<Res?> handle(Request req);

  // TODO :: handle after
  // Res? handleAfter(Res res);
}
