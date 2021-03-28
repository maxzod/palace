import 'package:meta/meta.dart';

import 'classes/endpoint.dart';
import 'classes/guard.dart';
import 'type_def.dart';

@immutable
class PalaceRouter {
  final List<EndPoint> _endpoints = [];
  final List<PalaceGuard> _globalGuards = [];

  void use(PalaceGuard guard) {
    _globalGuards.add(guard);
  }

  EndPoint match(String method, String path) {
    return _endpoints.firstWhere((e) => e.match(method, path), orElse: () {
      throw 'not found 404';
    });
  }

  List<PalaceGuard> get guards => _globalGuards;

  void get(
    String path,
    Handler handler, {
    List<PalaceGuard> guards = const [],
  }) {
    _endpoints.add(EndPoint(
      path: path,
      method: 'GET',
      handler: handler,
      guards: guards,
    ));
  }

  void post(
    String path,
    Handler handler, {
    List<PalaceGuard> guards = const [],
  }) {
    _endpoints.add(EndPoint(
      path: path,
      method: 'POST',
      handler: handler,
      guards: guards,
    ));
  }
}
