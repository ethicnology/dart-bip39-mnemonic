import 'dart:io';

/// BIP39:
/// * Since the vast majority of BIP39 wallets supports only the English wordlist, it is strongly discouraged to use non-English wordlists for generating the mnemonic sentences.
/// * If you still feel your application really needs to use a localized wordlist, use one of the following instead of inventing your own.
enum Language {
  french('french'),
  english('english'),
  spanish('spanish'),
  italian('italian'),
  czech('czech'),
  portuguese('portuguese'),
  korean('korean'),
  simplifiedChinese('chinese_simplified'),
  traditionalChinese('chinese_traditional'),
  japanese('japanese');

  final String label;
  const Language(this.label);

  List<String> get list {
    List<String> wordlist = [];
    var config = File("./lib/src/wordlists/$label.txt");
    List<String>? lines = config.readAsLinesSync();
    for (var word in lines) {
      wordlist.add(word);
    }
    return wordlist;
  }

  Map<int, String> get map => list.asMap();

  String get separator {
    if (this == Language.japanese) {
      return '\u{3000}'; // ideographic space
    } else {
      return '\u{0020}'; // space (SP)
    }
  }
}
