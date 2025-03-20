// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:unorm_dart/unorm_dart.dart';

import 'crypto.dart';
import 'language.dart';
import 'utils.dart';

/// BIP39: A mnemonic sentence is superior for human interaction compared to the handling of raw binary or hexadecimal representations of a wallet seed.
class Mnemonic {
  /// BIP39: The mnemonic must encode entropy in a multiple of 32 bits.
  /// With more entropy security is improved but the sentence length increases.
  /// The allowed size of _ENT is 128-256 bits.
  late List<int> entropy;

  /// The language affect the sentence and the seed generation.
  /// BIP39: Since the vast majority of BIP39 wallets supports only the English wordlist, it is strongly discouraged to use non-English wordlists for generating the mnemonic sentences. If you still feel your application really needs to use a localized wordlist, use one of the following instead of inventing your own.
  Language language;

  /// Passphrase is only used on seed generation.
  /// BIP39:  A user may decide to protect their mnemonic with a passphrase.
  /// If a passphrase is not present, an empty string "" is used instead.
  String passphrase;

  /// BIP39: We refer to the initial entropy length as ENT.
  int get _ENT => entropy.length * 8;

  /// BIP39: The checksum length (CS)
  int get _CS => _ENT ~/ 32;

  /// BIP39: The length of the generated mnemonic sentence (MS) in words.
  int get _MS => (_ENT + _CS) ~/ 11;

  /// BIP39: A checksum is generated by taking the first _ENT / 32 bits of its SHA256 hash.
  String get _checksum {
    List<int> hash = sha256(entropy);
    String bits = bytesToBits(hash);
    return bits.substring(0, _CS);
  }

  /// Returns entropy + checksum in binary string.
  /// BIP39: This checksum is appended to the end of the initial entropy.
  String get _binary {
    return bytesToBits(entropy) + _checksum;
  }

  /// Returns mnemonic indexes.
  /// BIP39: Next, these concatenated bits are split into groups of 11 bits, each encoding a number from 0-2047, serving as an index into a wordlist.
  List<int> get _indexes {
    List<int> indexes = [];
    for (var i = 0; i < _binary.length; i += 11) {
      String bit = _binary.substring(i, i + 11);
      indexes.add(int.parse(bit, radix: 2));
    }
    indexes.length != _MS ? throw Exception("mnemonic: indexes length") : null;
    return indexes;
  }

  /// BIP39: Finally, we convert these numbers (indexes) into words.
  List<String> get words {
    List<String> result = [];
    List<String> wordlist = language.list;
    for (int index in _indexes) {
      result.add(wordlist[index]);
    }
    return result;
  }

  /// BIP39: Use the joined words as a mnemonic sentence.
  String get sentence {
    return words.join(language.separator);
  }

  /// BIP39: To create a binary seed from the mnemonic, we use the PBKDF2 function with a mnemonic sentence (in UTF-8 NFKD) used as the password and the string "mnemonic" + passphrase (again in UTF-8 NFKD) used as the salt.
  /// The iteration count is set to 2048 and HMAC-SHA512 is used as the pseudo-random function.
  /// The length of the derived key is 512 bits (= 64 bytes). This seed can be later used to generate deterministic wallets using BIP-0032 or similar methods.
  List<int> get seed {
    var normalize = sentence.replaceAll(language.separator, '\u{0020}');
    return pbkdf2(normalize, passphrase: passphrase);
  }

  /// Constructs Mnemonic from entropy bytes.
  Mnemonic(this.entropy, this.language, {this.passphrase = ""}) {
    if (![128, 160, 192, 224, 256].contains(_ENT)) {
      throw Exception("mnemonic: unexpected initial entropy length");
    }
  }

  /// Constructs Mnemonic from one of these entropy lengths: [128, 160, 192, 224, 256]
  Mnemonic.generate(
    this.language, {
    this.passphrase = "",
    int entropyLength = 256,
  }) {
    if (![128, 160, 192, 224, 256].contains(entropyLength)) {
      throw Exception(
          "mnemonic: unexpected entropy length, choose one of: [128, 160, 192, 224, 256]");
    }
    var random = Random.secure();
    entropy = List<int>.generate(
      entropyLength ~/ 8,
      (i) => random.nextInt(256),
    );
  }

  /// Constructs Mnemonic from a sentence by retrieving the original entropy.
  Mnemonic.fromSentence(String sentence, this.language,
      {this.passphrase = ""}) {
    List<String> words = sentence.split(language.separator);
    List<int> indexes = [];
    Map<int, String> map = language.map;
    // convert to indexes.
    for (var word in words) {
      var nfkdWord = nfkd(word);
      if (map.containsValue(nfkdWord) == false) {
        throw Exception('mnemonic: "$word" does not exist in $language');
      } else {
        int index =
            map.entries.firstWhere((entry) => entry.value == nfkdWord).key;
        indexes.add(index);
      }
    }
    // determine checksum length in bits.
    int checksumLength;
    switch (indexes.length) {
      case 12:
        checksumLength = 4;
        break;
      case 15:
        checksumLength = 5;
        break;
      case 18:
        checksumLength = 6;
        break;
      case 21:
        checksumLength = 7;
        break;
      case 24:
        checksumLength = 8;
        break;
      default:
        throw Exception("mnemonic: unexpected sentence length");
    }
    // convert indexes to bits to remove the checksum.
    String bits = indexes
        .map((byte) => byte
            .toRadixString(2)
            .padLeft(11, '0')) // (each index is encoded on 11 bits)
        .join('');
    // remove checksum from bits.
    var bitsEntropy = bits.substring(0, bits.length - checksumLength);
    var extractedChecksum = bits.substring(bits.length - checksumLength);
    // converts bits entropy back to bytes.
    entropy = [];
    for (var i = 0; i < bitsEntropy.length; i += 8) {
      String bit = bitsEntropy.substring(i, i + 8);
      entropy.add(int.parse(bit, radix: 2));
    }
    if (_checksum != extractedChecksum) {
      throw Exception('mnemonic: invalid checksum');
    }
  }

  /// Constructs Mnemonic from a words, this new method use named parameters, the language is English by default.
  Mnemonic.fromWords({
    required List<String> words,
    Language language = Language.english,
    String passphrase = '',
  }) : this.fromSentence(
          words.join(language.separator),
          language,
          passphrase: passphrase,
        );
}
