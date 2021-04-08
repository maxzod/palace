import 'package:palace/palace.dart';
import 'package:test/test.dart';

void main() {
  test('router cant have two endpoints with the same path and method', () async {
    final router = Palace();
    try {
      router.get('/', (req, res) => '');
      router.get('/', (req, res) => '');
      await router.openGates();
      throw 'this cant be executed';
    } catch (e) {
      expect(e, equals('your endpoints have a duplicate try to fix it => method: GET ,path: / ,guardsCount 0'));
    } finally {
      await router.closeGates();
    }
  });
}
