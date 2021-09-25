import 'package:core/core.dart';
import 'package:router/src/endpoint.dart';
import 'package:router/src/endpoint_group.dart';
import 'package:path_to_regexp/path_to_regexp.dart';

part 'cashier.dart';
part 'guards_cashier.dart';

class PalaceRouter with RouterCashier, GuardsCashier {
  PalaceRouter();
}
