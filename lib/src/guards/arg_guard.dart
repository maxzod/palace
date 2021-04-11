import 'dart:async';

import 'package:palace/palace.dart';
import 'package:palace/src/decorators/handler_param.dart';

class ArgGuard extends PalaceGuard {
  final GuardArgs guard;

  const ArgGuard(this.guard);

  @override
  FutureOr<void> handle(Request req, Response res, @Next() Function next) => guard(req, res, next);
}
