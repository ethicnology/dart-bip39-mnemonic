import 'package:bip39_mnemonic/exports.dart';
import 'package:convert/convert.dart';

void main() {
  // DO NOT USE THESE DATA!
  String hexEntropy =
      "677765ded2b5f05fd11d9bcc38b863fda3fa06475c77bf1e99a668af355b96e2";
  List<int> bytesEntropy = hex.decode(hexEntropy);

  var mnemonic = Mnemonic(bytesEntropy, Language.english);
  String sentence = mnemonic.toSentence();
  print(sentence);
  // guess robot jeans pistol gallery copper dutch recall slow shift body win distance add buddy moment sample visit hat spend viable punch fortune faith

  List<int> bytesSeed = mnemonic.toSeed();
  String hexSeed = hex.encode(bytesSeed);
  print(hexSeed);
  // 1cbea444d42a98554a6984956509a19992ba500b30a789f7959bdb719c88d8e3ddd4c84522d60e2ac83591fc32c774e02a9719ea2bf4233c7a456f286b2cc0eb

  String frenchSentence =
      "image juteux calculer billard valise billard tortue besace peigne corbeau adroit littoral";
  var mnemonic2 = Mnemonic.fromSentence(frenchSentence, Language.french);
  print(hex.encode(mnemonic2.entropy));
  // 7e71249c8ebf603afb68e1b4c6fc18c8
  print(hex.encode(mnemonic2.toSeed()));
  // ad926f1f185ba7745f2c98733a83e51717a58ec83ef52c5cd12048aa8fbe4b2511cf12c2a514d2886510f7020b8a0c1c75bedacfbb3b34cd2f3d8d2c038d531e
}
