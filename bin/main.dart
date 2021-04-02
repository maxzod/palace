import 'controller.dart' as usersController;
import 'src/gates.dart';
import 'src/router/router.dart';
import 'utils/config_reader.dart';

/// you can run like any other dart project
/// but we recommend to use `lighthouse` packages to run and watch for changes
/// unit we finish the palace_cli
Future<void> main(List<String> args) async {
  /// create a router
  final router = PalaceRouter();

  /// you can add as many guards as you can to run before and after [noy yet implemented]
  /// build you own guard
  /// or use one of built-in guards
  // palace.use(loggerGuard);

  /// set your routes
  router.get('/greet_the_queen/:id/:age', (req, res) async {
    final enableLog = !config<bool>('production');
    return res.json({'data': req.params});
  }, guards: []);

  router.post('path', usersController.createOne);

  /// start the `server`
  await openGates(router);
}
