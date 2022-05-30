import 'package:bip39_mnemonic/src/wordlists/french.dart';
import 'package:bip39_mnemonic/src/wordlists/english.dart';
import 'package:bip39_mnemonic/src/wordlists/spanish.dart';
import 'package:bip39_mnemonic/src/wordlists/italian.dart';
import 'package:bip39_mnemonic/src/wordlists/czech.dart';
import 'package:bip39_mnemonic/src/wordlists/portuguese.dart';
import 'package:bip39_mnemonic/src/wordlists/korean.dart';
import 'package:bip39_mnemonic/src/wordlists/chinese_simplified.dart';
import 'package:bip39_mnemonic/src/wordlists/chinese_traditional.dart';
import 'package:bip39_mnemonic/src/wordlists/japanese.dart';

/// BIP39: Since the vast majority of BIP39 wallets supports only the English wordlist, it is strongly discouraged to use non-English wordlists for generating the mnemonic sentences.
/// If you still feel your application really needs to use a localized wordlist, use one of the following instead of inventing your own.
enum Language {
  english('english', englishList),
  french('french', frenchList),
  spanish('spanish', spanishList),
  italian('italian', italianList),
  portuguese('portuguese', portugueseList),
  czech('czech', czechList),
  korean('korean', koreanList),
  simplifiedChinese('chinese simplified', simplifiedChineseList),
  traditionalChinese('chinese traditional', traditionalChineseList),
  japanese('japanese', japaneseList);

  final String label;
  final List<String> _list;
  const Language(this.label, this._list);

  List<String> get list => _list;

  Map<int, String> get map => list.asMap();

  String get separator {
    if (this == Language.japanese) {
      return '\u{3000}'; // ideographic space
    } else {
      return '\u{0020}'; // space (SP)
    }
  }
}
