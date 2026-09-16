import 'package:flutter_test/flutter_test.dart';
import 'package:madperfume/core/constants/commerce_rules.dart';
import 'package:madperfume/core/models/loyalty_models.dart';
import 'package:madperfume/core/utils/validators.dart';

void main() {
  test('checkout preview follows backend tax contract', () {
    expect(CommerceRules.taxOn(100), 8);
    expect(CommerceRules.previewTotal(100), 108);
  });

  test('voucher discount comes off before tax and never below zero', () {
    expect(CommerceRules.appliedDiscount(100, 20), 20);
    expect(CommerceRules.taxable(100, discount: 20), 80);
    expect(CommerceRules.taxOn(CommerceRules.taxable(100, discount: 20)), 6.4);
    expect(CommerceRules.previewTotal(100, discount: 20), 86.4);
    expect(CommerceRules.appliedDiscount(10, 20), 10);
    expect(CommerceRules.previewTotal(10, discount: 20), 0);
  });

  test('unused boutique voucher name still resolves checkout discount', () {
    final voucher = RedemptionModel.fromJson({
      'id': 26,
      'voucher_code': 'RD-00026',
      'reward': 3,
      'name': '\$20 Boutique Voucher',
      'image_url': '',
      'points': 400,
      'status': 'processing',
      'created_at': '2026-09-16T00:00:00Z',
    });
    expect(voucher.isUnused, isTrue);
    expect(voucher.resolvedDiscount, 20);
    expect(voucher.isCheckoutVoucher, isTrue);
  });

  test('password follows backend strength rules', () {
    expect(Validators.password('short1!', 'invalid'), 'invalid');
    expect(Validators.password('longpassword', 'invalid'), 'invalid');
    expect(Validators.password('Strong#123', 'invalid'), isNull);
  });
}
