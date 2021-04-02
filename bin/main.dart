import 'src/gates.dart';
import 'src/guards/logger.dart';
import 'src/router/router.dart';
import 'utils/config_reader.dart';

/// you can run like any other dart project
/// but we recommend to use `lighthouse` packages to run and watch for changes
/// unit we finish the palace_cli
Future<void> main(List<String> args) async {
  final port = config<int>('port');

  print(port);

  return;

  /// create a router
  final palace = PalaceRouter();

  /// you can add as many guards as you can to run before and after [noy yet implemented]
  /// build you own guard
  /// or use one of built-in guards
  palace.use(loggerGuard);

  /// set your routes
  palace.get('/greet_the_queen/:id', (req, res) async {
    return res.json({'data': 'Long Live The Queen'});
  }, guards: []);

  /// start the `server`
  await openGates(palace, port: port);
}
