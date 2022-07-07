[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![codecov](https://codecov.io/gh/ethicnology/dart-bip39-mnemonic/branch/main/graph/badge.svg)](https://codecov.io/gh/ethicnology/dart-bip39-mnemonic)
[![CI](https://github.com/ethicnology/dart-bip39-mnemonic/actions/workflows/dart.yml/badge.svg)](https://github.com/ethicnology/dart-bip39-mnemonic/actions/workflows/dart.yml)
[![pub package](https://img.shields.io/pub/v/bip39_mnemonic.svg)](https://pub.dartlang.org/packages/bip39_mnemonic)

# dart-bip39-mnemonic
Mnemonic code for generating deterministic keys a.k.a. [BIP39](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki)  

## Getting started
```sh
dart pub add bip39_mnemonic
```


## [Features](https://github.com/bitcoin/bips/blob/master/bip-0039/bip-0039-wordlists.md)
* [English](https://github.com/bitcoin/bips/blob/master/bip-0039/english.txt)
* [Japanese](https://github.com/bitcoin/bips/blob/master/bip-0039/japanese.txt)
* [Korean](https://github.com/bitcoin/bips/blob/master/bip-0039/korean.txt)
* [Spanish](https://github.com/bitcoin/bips/blob/master/bip-0039/spanish.txt)
* [Chinese (Simplified)](https://github.com/bitcoin/bips/blob/master/bip-0039/chinese_simplified.txt)
* [Chinese (Traditional)](https://github.com/bitcoin/bips/blob/master/bip-0039/chinese_traditional.txt)
* [French](https://github.com/bitcoin/bips/blob/master/bip-0039/french.txt)
* [Italian](https://github.com/bitcoin/bips/blob/master/bip-0039/italian.txt)
* [Czech](https://github.com/bitcoin/bips/blob/master/bip-0039/czech.txt)
* [Portuguese](https://github.com/bitcoin/bips/blob/master/bip-0039/portuguese.txt)

## Usage

```dart
import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:convert/convert.dart'; // convert bytes to hexadecimal and vice-versa

void main() {
  // DO NOT USE THESE DATA!

  // Constructs Mnemonic from random secure 256bits entropy with optional passphrase
  var mnemonic =
      Mnemonic.generate(Language.french, passphrase: "SomethingR0bùst");
  print(mnemonic.sentence);
  // million alpaga revivre calmer dogme verdure capsule folie déborder facette lanceur saboter recycler tripler symbole savant rieur jeudi outrager volume situer jardin civil reculer
  String hexSeed = hex.encode(mnemonic.seed); // convert to hex
  print(hexSeed);
  // 7f12a3777d2cbf843f113ba2ed125511237c3c23d5adca17cb9a1036563cd0edca879ff374f224d40ca8a29942955644be61468baf6d84ba46651c5839420fe5

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
  print(hex.encode(mnemonic3.seed));
  // ad926f1f185ba7745f2c98733a83e51717a58ec83ef52c5cd12048aa8fbe4b2511cf12c2a514d2886510f7020b8a0c1c75bedacfbb3b34cd2f3d8d2c038d531e

  // Check if a word is BIP39 compatible
  print(Language.english.isValid('baguette')); // false

  // NFKD word formatting is mandatory in BIP39, please take care: https://github.com/flutter/flutter/issues/104927#issuecomment-1141140735
  var french = Language.french;
  String nfkdDisabled = 'échelle';
  String nfkdEnabled = 'échelle';
  print(french.isValid(nfkdDisabled)); // false
  print(french.isValid(nfkdEnabled)); // true
  print(french.isValid(nfkd(nfkdDisabled))); // NFKD formatted using unorm
}

```