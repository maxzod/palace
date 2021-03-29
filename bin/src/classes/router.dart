import 'package:meta/meta.dart';

import 'endpoint.dart';
import 'guard.dart';

@immutable
class PalaceRouter {
  final List<EndPoint> _endpoints = [];
  final List<PalaceGuard> _globalGuards = [];

  void use(PalaceGuard guard) => _globalGuards.add(guard);

  EndPoint? match(String method, String path) {
    try {
      return _endpoints.firstWhere((e) => e.match(method, path));
    } catch (e) {
      if (e is StateError) return null;
      rethrow;
    }
  }

  List<PalaceGuard> get guards => _globalGuards;

  void get(
    String path,
    Handler handler, {
    List<PalaceGuard> guards = const [],
  }) {
    // TODO :: throw error if endpoint is already reserved
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
