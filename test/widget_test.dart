import 'package:flutter_test/flutter_test.dart';
import 'package:madperfume/core/constants/commerce_rules.dart';
import 'package:madperfume/core/utils/validators.dart';

void main() {
  test('checkout preview follows backend tax contract', () {
    expect(CommerceRules.taxOn(100), 8);
    expect(CommerceRules.previewTotal(100), 108);
  });

  test('password follows backend strength rules', () {
    expect(Validators.password('short1!', 'invalid'), 'invalid');
    expect(Validators.password('longpassword', 'invalid'), 'invalid');
    expect(Validators.password('Strong#123', 'invalid'), isNull);
  });
}
