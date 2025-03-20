[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/license/mit)
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

Please take a look at the examples in the folder `example`

### Generate a Mnemonic
```dart
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
```

### Construct a Mnemonic from Words
```dart
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
  // You can also specify the language and the passphrase in the named parameters
  final mnemonic2 = Mnemonic.fromWords(words: words);
  print(hex.encode(mnemonic2.seed));
```

### Construct a Mnemonic from Entropy bytes
```dart
  // Constructs a Mnemonic from Entropy bytes
  String hexEntropy =
      "677765ded2b5f05fd11d9bcc38b863fda3fa06475c77bf1e99a668af355b96e2";
  List<int> bytesEntropy = hex.decode(hexEntropy);

  final mnemonic3 = Mnemonic(bytesEntropy, Language.english);
  print(mnemonic3.sentence);
  // guess robot jeans pistol gallery copper dutch recall slow shift body win distance add buddy moment sample visit hat spend viable punch fortune faith
```

### Construct a Mnemonic from a Sentence
```dart
  // Constructs a Mnemonic from a Sentence/Phrase
  String frenchSentence =
      "image juteux calculer billard valise billard tortue besace peigne corbeau adroit littoral";
      
  final mnemonic4 = Mnemonic.fromSentence(frenchSentence, Language.french);
  print(hex.encode(mnemonic4.entropy));
  // 7e71249c8ebf603afb68e1b4c6fc18c8
  print(hex.encode(mnemonic4.seed));
  // ad926f1f185ba7745f2c98733a83e51717a58ec83ef52c5cd12048aa8fbe4b2511cf12c2a514d2886510f7020b8a0c1c75bedacfbb3b34cd2f3d8d2c038d531e
```

### Helpers to check words are BIP39 compatible
```dart
import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:convert/convert.dart'; // convert bytes to hexadecimal and vice-versa

void main() {
  // Check if a word is BIP39 compatible for a specific language
  print(Language.english.isValid('baguette')); // false

  // NFKD word formatting is mandatory in BIP39, please take care: https://github.com/flutter/flutter/issues/104927#issuecomment-1141140735
  final french = Language.french;
  String nonNfkd = 'échelle';
  String nfkd = 'échelle';
  print(french.isValid(nfkd)); // true
  print(french.isValid(nonNfkd)); // true, because isValid formats input
}
```