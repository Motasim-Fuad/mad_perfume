import 'package:madperfume/core/constants/api_endpoints.dart';
import 'package:madperfume/core/models/loyalty_models.dart';
import 'package:madperfume/core/network/api_client.dart';
import 'package:madperfume/core/network/paginated.dart';

class LoyaltyRepository {
  LoyaltyRepository(this._api);

  final ApiClient _api;

  Future<LoyaltySummary> summary() {
    return _api.get(
      ApiEndpoints.loyalty,
      parse: (data) => LoyaltySummary.fromJson(_map(data)),
    );
  }

  Future<Paginated<PointsTransaction>> transactions({
    String? kind,
    String? channel,
    int page = 1,
  }) {
    return _api.get(
      ApiEndpoints.loyaltyTransactions,
      query: {'kind': kind, 'channel': channel, 'page': page},
      parse: (data) =>
          Paginated.fromJson(_map(data), PointsTransaction.fromJson),
    );
  }

  Future<List<RewardModel>> rewards({String? category}) {
    return _api.get(
      ApiEndpoints.rewards,
      query: {'category': category},
      parse: (data) {
        if (data is! List) {
          return <RewardModel>[];
        }
        return data
            .whereType<Map>()
            .map(
              (item) => RewardModel.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
      },
    );
  }

  Future<RewardModel> reward(int id) {
    return _api.get(
      ApiEndpoints.reward(id),
      parse: (data) => RewardModel.fromJson(_map(data)),
    );
  }

  Future<RedemptionModel> redeem(int id) {
    return _api.post(
      ApiEndpoints.rewardRedeem(id),
      parse: (data) => RedemptionModel.fromJson(_map(data)),
    );
  }

  Future<Paginated<RedemptionModel>> redemptions({
    int page = 1,
    bool usable = false,
  }) {
    return _api.get(
      ApiEndpoints.redemptions,
      query: {'page': page, if (usable) 'usable': 'true'},
      parse: (data) => Paginated.fromJson(_map(data), RedemptionModel.fromJson),
    );
  }

  Future<Paginated<AppNotification>> notifications({
    String? category,
    int page = 1,
  }) {
    return _api.get(
      ApiEndpoints.notifications,
      query: {'category': category, 'page': page},
      parse: (data) => Paginated.fromJson(_map(data), AppNotification.fromJson),
    );
  }

  Future<int> unreadCount() {
    return _api.get(
      ApiEndpoints.notificationsUnread,
      parse: (data) {
        final map = _map(data);
        return map['unread'] is num ? (map['unread'] as num).toInt() : 0;
      },
    );
  }

  Future<void> markRead(int id) {
    return _api.patch<void>(
      ApiEndpoints.notification(id),
      data: {'is_read': true},
      parse: (_) {},
    );
  }

  Future<void> markAllRead() {
    return _api.post<void>(ApiEndpoints.notificationsReadAll, parse: (_) {});
  }

  Map<String, dynamic> _map(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return const {};
  }
}
