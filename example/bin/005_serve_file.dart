import 'package:palace/palace.dart';

Future<void> main(List<String> arguments) async {
  /// * you can run as any normal dart app
  /// ? or user the light house to run and watch for changes  'package:lighthouse'

  final router = PalaceRouter();
  await openGates(router);
}
