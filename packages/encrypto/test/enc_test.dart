import 'dart:convert';
import 'package:encrypto/encrypto.dart';
import 'package:queen_env/queen_env.dart';
import 'package:test/test.dart';

void main() {
  setUp(() async {
    await loadEnv();
  });

  final testData = utf8.encode('Hello, World!');

  test('Hashing', () async {
    final hash = await Encrypto.hash(testData, EncryptoHashAlgorithms.sha256);
    expect(
        hash,
        equals(
            'dffd6021bb2bd5b0af676290809ec3a53191dd81c7f70a4b28688a362182986f'));
  });

  test('Encrypting/Decrypting', () async {
    final key = envOrNull('secret');
    if (key == null) throw 'must have key in .env';

    final testKey = SecretKey(utf8.encode(key));
    final encryptedData =
        await Encrypto.cipheredEncrypt(testData, AesGcm.with128bits(), testKey);

    final decryptedData = await Encrypto.cipheredDecrypt(
        encryptedData, testKey, AesGcm.with128bits());
    expect(utf8.decode(decryptedData), 'Hello, World!');
  });

  test('Signing/Validating', () async {
    final signture = await Encrypto.sign(testData, Ed25519());

    final isValidated = await Encrypto.validateSignature(testData,signture,Ed25519());

    expect(isValidated, true);
  });
}
