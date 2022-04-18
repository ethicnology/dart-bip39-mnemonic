import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:convert/convert.dart'; // to convert bytes to hexadecimal and vice-versa

void main() {
  // DO NOT USE THESE DATA!

  // Constructs Mnemonic from random secure 256bits entropy
  var mnemonic = Mnemonic.generate(Language.french);
  print(mnemonic.sentence);
  // million alpaga revivre calmer dogme verdure capsule folie déborder facette lanceur saboter recycler tripler symbole savant rieur jeudi outrager volume situer jardin civil reculer
  List<int> bytesSeed = mnemonic.toSeed(passphrase: "GPLv3");
  String hexSeed = hex.encode(bytesSeed); // convert to hex
  print(hexSeed);
  // 9097c95aa6a100792973041c3701bff43bfcd39995fc75da0ec56bd74111fcb7759752b08040bc10db537fe86d4bcb44b95c450b04a9a9c3913e247f4f99e9e8

  // Constructs a Mnemonic from Entropy
  String hexEntropy =
      "677765ded2b5f05fd11d9bcc38b863fda3fa06475c77bf1e99a668af355b96e2";
  List<int> bytesEntropy = hex.decode(hexEntropy);
  var mnemonic2 = Mnemonic(bytesEntropy, Language.english);
  print(mnemonic2.sentence);
  // guess robot jeans pistol gallery copper dutch recall slow shift body win distance add buddy moment sample visit hat spend viable punch fortune faith

// Constructs a Mnemonic from Sentence/Phrase
  String frenchSentence =
      "image juteux calculer billard valise billard tortue besace peigne corbeau adroit littoral";
  var mnemonic3 = Mnemonic.fromSentence(frenchSentence, Language.french);
  print(hex.encode(mnemonic3.entropy));
  // 7e71249c8ebf603afb68e1b4c6fc18c8
  print(hex.encode(mnemonic3.toSeed()));
  // ad926f1f185ba7745f2c98733a83e51717a58ec83ef52c5cd12048aa8fbe4b2511cf12c2a514d2886510f7020b8a0c1c75bedacfbb3b34cd2f3d8d2c038d531e
}
