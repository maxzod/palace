import 'dart:io';

import 'src/classes/palace.dart';
import 'src/classes/router.dart';
import 'src/guards/logger.dart';

/// you can run like any other dart project
/// but we recommend to use `lighthouse` packages to run and watch for changes
/// unit we finish the palace_cli
Future<void> main(List<String> args) async {
  /// create a router
  final palace = PalaceRouter();

  /// you can add as many guards as you can to run before and after [noy yet implemented]
  /// build you own guard
  /// or use one of built-in guards
  palace.use(LoggerGuard());

  /// set your routes
  palace.get('/greet_the_queen', (req, res) async {
    return res.json(
      {
        'data': 'Long Live The Queen',
      },

      /// optionally you can set your `statusCode`
      /// by defaults we will attach the appropriate status code depend on the req.method
      /// `GET` => (`ok`)200  , `POST` => 201(`created`)

      statusCode: HttpStatus.ok,
    );
  });

  /// start the `server`
  await openGates(palace);
}
