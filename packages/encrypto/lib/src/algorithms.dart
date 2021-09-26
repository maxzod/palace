import 'package:encrypto/encrypto.dart';

abstract class EncryptoHashAlgorithms extends HashAlgorithm {
  static final blake2b = Blake2b();
  static final blake2s = Blake2s();
  static final sha1 = Sha1();
  static final sha224 = Sha224();
  static final sha256 = Sha256();
  static final sha384 = Sha384();
  static final sha512 = Sha384();
}

