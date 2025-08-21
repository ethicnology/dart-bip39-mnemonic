import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:convert/convert.dart';
import 'package:test/test.dart';

void main() {
  const zooEntropy = 'ffffffffffffffffffffffffffffffff';

  group('Mnemonic internationalization', () {
    for (var language in Language.values) {
      test(language.label, () {
        final mnemonic = Mnemonic(hex.decode(zooEntropy), language);
        expect(hex.encode(mnemonic.entropy), equals(zooEntropy));
      });
    }
  });
}
