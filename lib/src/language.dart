import 'wordlists/french.dart';
import 'wordlists/english.dart';

/// BIP39:
/// * Since the vast majority of BIP39 wallets supports only the English wordlist, it is strongly discouraged to use non-English wordlists for generating the mnemonic sentences.
/// * If you still feel your application really needs to use a localized wordlist, use one of the following instead of inventing your own.
enum Language { french, english }

extension LanguageExtension on Language {
  List<String> get list {
    switch (this) {
      case Language.french:
        return french;
      case Language.english:
        return english;
    }
  }

  Map<int, String> get map {
    switch (this) {
      case Language.french:
        return french.asMap();
      case Language.english:
        return english.asMap();
    }
  }
}
