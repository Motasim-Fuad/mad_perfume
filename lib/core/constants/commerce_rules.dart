class CommerceRules {
  CommerceRules._();

  static const double taxRate = 0.08;

  static double taxOn(double subtotal) => subtotal * taxRate;

  static double previewTotal(double subtotal) => subtotal + taxOn(subtotal);
}
