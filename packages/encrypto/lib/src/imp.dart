import 'package:encrypto/encrypto.dart';

abstract class EncryptoImp {
  const EncryptoImp();

  Future<String> hash(List<int> value, HashAlgorithm alg);

  Future<SecretBox> cipheredEncrypt(List<int> byteData, Cipher cipher,
      SecretKey existingKey);
  Future<List<int>> cipheredDecrypt(
      SecretBox encryptedData, SecretKey secretKey, Cipher cipher);

  Future<Signature> sign(
      List<int> byteData, SignatureAlgorithm signatureAlgorithm);
  Future<bool> validateSignature(List<int> byteData, Signature signature,
      SignatureAlgorithm signatureAlgorithm);
}
