import 'wordlists/french.dart';
import 'wordlists/english.dart';
import 'wordlists/spanish.dart';
import 'wordlists/italian.dart';
import 'wordlists/czech.dart';
import 'wordlists/portuguese.dart';
import 'wordlists/korean.dart';
import 'wordlists/chinese_simplified.dart';
import 'wordlists/chinese_traditional.dart';
import 'wordlists/japanese.dart';

/// BIP39:
/// * Since the vast majority of BIP39 wallets supports only the English wordlist, it is strongly discouraged to use non-English wordlists for generating the mnemonic sentences.
/// * If you still feel your application really needs to use a localized wordlist, use one of the following instead of inventing your own.
enum Language {
  french,
  english,
  spanish,
  italian,
  czech,
  portuguese,
  korean,
  simplifiedChinese,
  traditionalChinese,
  japanese
}

extension LanguageExtension on Language {
  List<String> get list {
    switch (this) {
      case Language.french:
        return french;
      case Language.english:
        return english;
      case Language.spanish:
        return spanish;
      case Language.italian:
        return italian;
      case Language.czech:
        return czech;
      case Language.portuguese:
        return portuguese;
      case Language.korean:
        return korean;
      case Language.simplifiedChinese:
        return simplifiedChinese;
      case Language.traditionalChinese:
        return traditionalChinese;
      case Language.japanese:
        return japanese;
    }
  }

  Map<int, String> get map {
    switch (this) {
      case Language.french:
        return french.asMap();
      case Language.english:
        return english.asMap();
      case Language.spanish:
        return spanish.asMap();
      case Language.italian:
        return italian.asMap();
      case Language.czech:
        return czech.asMap();
      case Language.portuguese:
        return portuguese.asMap();
      case Language.korean:
        return korean.asMap();
      case Language.simplifiedChinese:
        return simplifiedChinese.asMap();
      case Language.traditionalChinese:
        return traditionalChinese.asMap();
      case Language.japanese:
        return japanese.asMap();
    }
  }

  String get separator {
    if (this == Language.japanese) {
      return '\u{3000}'; // ideographic space
    } else {
      return '\u{0020}'; // space (SP)
    }
  }
}
