import 'dart:io';

import 'package:env/env.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  setUp(() async {
    /// create env file
    final _envFile = File('.env');
    if (await _envFile.exists()) {
      await _envFile.create();
    }
    await _envFile.writeAsBytes(
      '''
     name=queen_env
    // you can add comments
     ## it will not effect any thing  
     PART_OF=queen
    '''
          .codeUnits,
    );

    /// ! important to load the env files
    await loadEnv();
  });

  test(
    'read env value while its exist with env()',
    () {
      // load env value
      final name = env('name');
      // check if it matches the excpected one
      expect(name, equals('queen_env'));
    },
  );

  test(
      'read env value while it does not exist with env() will returns empty string',
      () {
    final name = env('404_key');
    expect(name, equals(''));
  });
  test(
      'read env value while it does not exist with envOrNull() will returns Null',
      () {
    final name = envOrNull('404_key');
    expect(name, equals(null));
  });

  // tearDown(() async {
  //   /// delete the env file
  //   final _envFile = File('.env');
  //   if (await _envFile.exists()) {
  //     await _envFile.delete();
  //   }
  // });
}
