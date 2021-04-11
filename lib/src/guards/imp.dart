import 'dart:async';

import 'package:palace/palace.dart';
import 'package:palace/src/decorators/handler_param.dart';
import 'package:palace/src/guards/arg_guard.dart';

abstract class PalaceGuard {
  const PalaceGuard();
  FutureOr<void> handle(Request req, Response res, @Next() Function next);
}

extension QuickGuard on PalaceGuard {
  static ArgGuard arg(GuardArgs args) => ArgGuard(args);
}
