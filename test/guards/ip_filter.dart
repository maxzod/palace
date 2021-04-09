import 'package:palace/palace.dart';
import 'package:palace/src/exceptions/imp_exception.dart';
import 'package:test/test.dart';

void main() {
  var router = Palace();

  test('Blacklisted', () async {
    await router.openGates();
    router.all('/', (req, res) async {
      expect(res.statusCode, equals(HttpStatus.unauthorized));
    }, guards: [Blacklisted()]);
    await router.closeGates();
  });
  test('Whitelisted', () async {
    await router.openGates();
    router.all('/', (req, res) async {
      expect(res.statusCode, equals(HttpStatus.unauthorized));
    }, guards: [Whitelisted()]);
    await router.closeGates();
  });
}
