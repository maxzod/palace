import 'package:palace/palace.dart';

Future<void> main(List<String> arguments) async {
  /// * you can run as any normal dart app
  /// ? or user the light house to run and watch for changes  'package:lighthouse'

  final router = PalaceRouter();
  router.get('/', (req, res) => res.file('/kingdom_constitution.txt'.toUpperCase(), name: 'بالعربي'));
  // router.get('/', (req, res) {
  //   res.write('Long Live The Queen !');
  //   final file = File('');
  //   // res.request.response.addStream(file.read)
  // });
  await openGates(router);
}
