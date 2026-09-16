class CommerceRules {
  CommerceRules._();

  static const double taxRate = 0.08;

  static double appliedDiscount(double subtotal, double voucherAmount) {
    if (voucherAmount <= 0 || subtotal <= 0) {
      return 0;
    }
    return voucherAmount < subtotal ? voucherAmount : subtotal;
  }

  static double taxable(double subtotal, {double discount = 0}) {
    final net = subtotal - appliedDiscount(subtotal, discount);
    return net < 0 ? 0 : net;
  }

  static double taxOn(double amount) => amount * taxRate;

  static double previewTotal(double subtotal, {double discount = 0}) {
    final net = taxable(subtotal, discount: discount);
    return net + taxOn(net);
  }
}
