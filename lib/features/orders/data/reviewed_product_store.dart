import 'package:madperfume/core/constants/storage_keys.dart';
import 'package:madperfume/core/services/storage_service.dart';

class ReviewedProductStore {
  ReviewedProductStore(this._storage);

  final StorageService _storage;

  Set<int> read(int userId) {
    return _storage
        .readList(StorageKeys.reviewedProducts(userId))
        .map((value) => int.tryParse('$value'))
        .whereType<int>()
        .toSet();
  }

  bool contains({required int userId, required int productId}) {
    return read(userId).contains(productId);
  }

  Future<void> mark({required int userId, required int productId}) async {
    final ids = read(userId)..add(productId);
    await _storage.write(
      StorageKeys.reviewedProducts(userId),
      ids.toList()..sort(),
    );
  }
}
