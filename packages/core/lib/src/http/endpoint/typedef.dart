import 'dart:async';

import 'package:core/core.dart';

typedef HandlerFunc = FutureOr<Object?> Function(
  Request req,
  Response res,
);
typedef GuardFunc = FutureOr<Object?> Function(
  Request req,
  Response res,
  Function() next,
);
