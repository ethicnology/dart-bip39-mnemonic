import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:unorm_dart/unorm_dart.dart';

typedef Bits = List<bool>;

extension BitsExtension on Bits {
  static Bits fromString(String bits) {
    // if string does not contain 1 or 0, throw an error
    if (bits.contains(RegExp(r'[^01]'))) throw 'Invalid bits string';
    return bits.split('').map((bit) => bit == '1').toList();
  }

  static Bits fromBytes(List<int> bytes) {
    final stringBits =
        bytes.map((byte) => byte.toRadixString(2).padLeft(8, '0')).join('');
    return fromString(stringBits);
  }

  static Bits fromIndexes(List<int> indexes) {
    final paddedBits = indexes
        .map((byte) => byte
            .toRadixString(2)
            .padLeft(11, '0')) // (each index is encoded on 11 bits)
        .join('');
    return fromString(paddedBits);
  }

  static Bits fromWords(List<String> words, Language language) {
    List<int> indexes = [];
    Map<int, String> map = language.map;
    // convert to indexes.
    for (var word in words) {
      final nfkdWord = nfkd(word);
      if (map.containsValue(nfkdWord) == false) {
        throw MnemonicWordNotFoundException(word, language.name);
      } else {
        final index =
            map.entries.firstWhere((entry) => entry.value == nfkdWord).key;
        indexes.add(index);
      }
    }

    return BitsExtension.fromIndexes(indexes);
  }

  List<int> toBytes() {
    final bytes = <int>[];
    for (var i = 0; i < length; i += 8) {
      final byte = sublist(i, i + 8).map((bit) => bit ? 1 : 0).join('');
      bytes.add(int.parse(byte, radix: 2));
    }
    return bytes;
  }

  String toBinaryString() => map((bit) => bit ? '1' : '0').join('');
}
