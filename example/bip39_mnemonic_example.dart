import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:convert/convert.dart'; // convert bytes to hexadecimal and vice-versa

void main() {
  // DO NOT USE THESE DATA!

  // Constructs Mnemonic from random secure 256bits entropy with optional passphrase
  final mnemonic = Mnemonic.generate(
    Language.french,
    passphrase: "SomethingR0bùst",
    entropyLength: 256,
  );
  print(mnemonic.sentence);
  // million alpaga revivre calmer dogme verdure capsule folie déborder facette lanceur saboter recycler tripler symbole savant rieur jeudi outrager volume situer jardin civil reculer
  String hexSeed = hex.encode(mnemonic.seed); // convert to hex
  print(hexSeed);
  // 7f12a3777d2cbf843f113ba2ed125511237c3c23d5adca17cb9a1036563cd0edca879ff374f224d40ca8a29942955644be61468baf6d84ba46651c5839420fe5

  //
  //
  // Generate a mnemonic from words with English as default language
  List<String> words = [
    'raise',
    'beach',
    'verb',
    'shell',
    'soft',
    'tumble',
    'satoshi',
    'wink',
    'clown',
    'enjoy',
    'more',
    'senior'
  ];
  final mnemonic2 = Mnemonic.fromWords(words: words);
  print(hex.encode(mnemonic2.seed));

  //
  //
  // Constructs a Mnemonic from Entropy bytes
  String hexEntropy =
      "677765ded2b5f05fd11d9bcc38b863fda3fa06475c77bf1e99a668af355b96e2";
  List<int> bytesEntropy = hex.decode(hexEntropy);
  final mnemonic3 = Mnemonic(bytesEntropy, Language.english);
  print(mnemonic3.sentence);
  // guess robot jeans pistol gallery copper dutch recall slow shift body win distance add buddy moment sample visit hat spend viable punch fortune faith

  // Constructs a Mnemonic from a Sentence/Phrase
  String frenchSentence =
      "image juteux calculer billard valise billard tortue besace peigne corbeau adroit littoral";
  final mnemonic4 = Mnemonic.fromSentence(frenchSentence, Language.french);
  print(hex.encode(mnemonic4.entropy));
  // 7e71249c8ebf603afb68e1b4c6fc18c8
  print(hex.encode(mnemonic4.seed));
  // ad926f1f185ba7745f2c98733a83e51717a58ec83ef52c5cd12048aa8fbe4b2511cf12c2a514d2886510f7020b8a0c1c75bedacfbb3b34cd2f3d8d2c038d531e

  //
  //
  // Check if a word is BIP39 compatible
  print(Language.english.isValid('baguette')); // false

  //
  //
  // NFKD word formatting is mandatory in BIP39, please take care: https://github.com/flutter/flutter/issues/104927#issuecomment-1141140735
  final french = Language.french;
  String nonNfkd = 'échelle';
  String nfkd = 'échelle';
  print(french.isValid(nfkd)); // true
  print(french.isValid(nonNfkd)); // true, because isValid formats input
}
