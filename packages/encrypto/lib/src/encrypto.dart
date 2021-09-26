import 'package:convert/convert.dart';
import 'package:encrypto/encrypto.dart';
import 'package:encrypto/src/imp.dart';
import 'package:cryptography/cryptography.dart';

const Encrypto = _Encrypto();

class _Encrypto extends EncryptoImp {
  const _Encrypto();

  /// * hashing data according to the selected Algorithm
  ///
  /// ## Example: simple usage
  /// ```
  /// import 'package:encrypto/encrypto.dart';
  ///
  /// void main() async {
  ///   final algorithm = EncryptoHashAlgorithms.sha256;
  ///   final hash = await Encrypto.hash(utf8.encode('Hello, World!'), algorithm);
  ///   print('Hash: $hash');
  /// }
  /// ```
  /// ## Available algorithms
  ///   * [Blake2b]
  ///   * [Blake2s]
  ///   * [Sha1]
  ///   * [Sha224] (SHA2-224)
  ///   * [Sha256] (SHA2-256)
  ///   * [Sha384] (SHA2-384)
  ///   * [Sha512] (SHA2-512)
  @override
  Future<String> hash(List<int> byteData, HashAlgorithm algorithm) async {
    final hashBytes = await algorithm.hash(byteData);
    final hash = hex.encode(hashBytes.bytes);
    return hash;
  }

  ///* Encrypting data using the selected cipher and the used secretKey found in .env
  @override
  Future<SecretBox> cipheredEncrypt(
      List<int> byteData, Cipher cipher, SecretKey secretKey) async {
    // declaring the algorithm from the cipher
    final algorithm = cipher;

    // Encrypt
    final encryptedData = await algorithm.encrypt(
      byteData,
      secretKey: secretKey,
    );

    //showing some nerdy data
    print('Nonce: ${hex.encode(encryptedData.nonce)}');
    print('Ciphertext: ${hex.encode(encryptedData.cipherText)}');
    print('MAC: ${hex.encode(encryptedData.mac.bytes)}');
    return encryptedData;
  }

  ///* decrypting ciphered data using the secretKey found in .env
  @override
  Future<List<int>> cipheredDecrypt(
    SecretBox encryptedData,
    SecretKey secretKey,
    Cipher cipher,
  ) async {
    // declaring the algorithm from the cipher
    final algorithm = cipher;

    // Decrypting the data using the key given
    final decryptedData =
        await algorithm.decrypt(encryptedData, secretKey: secretKey);

    return decryptedData;
  }

  @override
  Future<Signature> sign(
      List<int> byteData, SignatureAlgorithm signatureAlgorithm) async {
    // Generate a keypair.
    final algorithm = signatureAlgorithm;
    final keyPair = await algorithm.newKeyPair();

    // Sign
    final signature = await algorithm.sign(
      byteData,
      keyPair: keyPair,
    );

    //showing some nerdy data
    print('Signature: ${hex.encode(signature.bytes)}');
    print(
        'Public key: ${hex.encode((signature.publicKey as SimplePublicKey).bytes)}');
    print('Public key type: ${signature.publicKey.type.name}');

    return signature;
  }

  @override
  Future<bool> validateSignature(List<int> byteData, Signature signature,
      SignatureAlgorithm signatureAlgorithm) async {
    final algorithm = signatureAlgorithm;
    return await algorithm.verify(
      byteData,
      signature: signature,
    );
  }
}