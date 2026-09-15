import 'package:flutter_test/flutter_test.dart';
import 'package:madperfume/core/constants/catalog_data.dart';

void main() {
  test('catalog collections match products', () {
    final ids = CatalogData.collections.map((item) => item.id).toSet();
    for (final product in CatalogData.products) {
      expect(ids.contains(product.collectionId), isTrue);
    }
    expect(CatalogData.usdPerPoint, 0.01);
  });
}
