import 'package:madperfume/core/utils/json_read.dart';

class LoyaltySummary {
  const LoyaltySummary({
    required this.pointsBalance,
    required this.lifetimePoints,
    required this.tier,
    required this.nextTier,
    required this.pointsToNextTier,
    required this.tierProgress,
    required this.tiers,
    required this.earnRates,
    required this.recentActivity,
  });

  final int pointsBalance;
  final int lifetimePoints;
  final String tier;
  final String? nextTier;
  final int pointsToNextTier;
  final int tierProgress;
  final Map<String, int> tiers;
  final Map<String, int> earnRates;
  final List<PointsTransaction> recentActivity;

  static const empty = LoyaltySummary(
    pointsBalance: 0,
    lifetimePoints: 0,
    tier: 'silver',
    nextTier: 'gold',
    pointsToNextTier: 0,
    tierProgress: 0,
    tiers: {},
    earnRates: {},
    recentActivity: [],
  );

  factory LoyaltySummary.fromJson(Map<String, dynamic> json) {
    final tiersRaw = json['tiers'];
    final ratesRaw = json['earn_rates'];
    final activityRaw = json['recent_activity'];
    return LoyaltySummary(
      pointsBalance: JsonRead.integer(json['points_balance']),
      lifetimePoints: JsonRead.integer(json['lifetime_points']),
      tier: JsonRead.text(json['tier']),
      nextTier: json['next_tier']?.toString(),
      pointsToNextTier: JsonRead.integer(json['points_to_next_tier']),
      tierProgress: JsonRead.integer(json['tier_progress']),
      tiers: tiersRaw is Map
          ? tiersRaw.map(
              (key, value) => MapEntry(key.toString(), JsonRead.integer(value)),
            )
          : const {},
      earnRates: ratesRaw is Map
          ? ratesRaw.map(
              (key, value) => MapEntry(key.toString(), JsonRead.integer(value)),
            )
          : const {},
      recentActivity: activityRaw is List
          ? activityRaw
                .whereType<Map>()
                .map(
                  (item) => PointsTransaction.fromJson(
                    Map<String, dynamic>.from(item),
                  ),
                )
                .toList()
          : const [],
    );
  }
}

class PointsTransaction {
  const PointsTransaction({
    required this.id,
    required this.reference,
    required this.title,
    required this.kind,
    required this.reason,
    required this.channel,
    required this.points,
    required this.balanceAfter,
    required this.createdAt,
    this.branchName,
    this.purchaseAmount,
  });

  final int id;
  final String reference;
  final String title;
  final String kind;
  final String reason;
  final String channel;
  final int points;
  final int balanceAfter;
  final String createdAt;
  final String? branchName;
  final String? purchaseAmount;

  bool get isRedeemed => kind == 'redeemed' || points < 0;

  factory PointsTransaction.fromJson(Map<String, dynamic> json) {
    return PointsTransaction(
      id: JsonRead.integer(json['id']),
      reference: JsonRead.text(json['reference']),
      title: JsonRead.text(json['title']),
      kind: JsonRead.text(json['kind']),
      reason: JsonRead.text(json['reason']),
      channel: JsonRead.text(json['channel']),
      points: JsonRead.integer(json['points']),
      balanceAfter: JsonRead.integer(json['balance_after']),
      createdAt: JsonRead.text(json['created_at']),
      branchName: json['branch_name']?.toString(),
      purchaseAmount: json['purchase_amount']?.toString(),
    );
  }
}

class RewardModel {
  const RewardModel({
    required this.id,
    required this.name,
    required this.pointsRequired,
    required this.category,
    required this.eligibility,
    required this.description,
    required this.imageUrl,
    required this.canRedeem,
  });

  final int id;
  final String name;
  final int pointsRequired;
  final String category;
  final String eligibility;
  final String description;
  final String imageUrl;
  final bool canRedeem;

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      id: JsonRead.integer(json['id']),
      name: JsonRead.text(json['name']),
      pointsRequired: JsonRead.integer(json['points_required']),
      category: JsonRead.text(json['category']),
      eligibility: JsonRead.text(json['eligibility']),
      description: JsonRead.text(json['description']),
      imageUrl: JsonRead.text(json['image_url']),
      canRedeem: JsonRead.flag(json['can_redeem']),
    );
  }
}

class RedemptionModel {
  const RedemptionModel({
    required this.id,
    required this.voucherCode,
    required this.reward,
    required this.name,
    required this.imageUrl,
    required this.points,
    required this.status,
    required this.createdAt,
    this.fulfilledAt,
  });

  final int id;
  final String voucherCode;
  final int reward;
  final String name;
  final String imageUrl;
  final int points;
  final String status;
  final String createdAt;
  final String? fulfilledAt;

  factory RedemptionModel.fromJson(Map<String, dynamic> json) {
    return RedemptionModel(
      id: JsonRead.integer(json['id']),
      voucherCode: JsonRead.text(json['voucher_code']),
      reward: JsonRead.integer(json['reward']),
      name: JsonRead.text(json['name']),
      imageUrl: JsonRead.text(json['image_url']),
      points: JsonRead.integer(json['points']),
      status: JsonRead.text(json['status']),
      createdAt: JsonRead.text(json['created_at']),
      fulfilledAt: json['fulfilled_at']?.toString(),
    );
  }
}

class AppNotification {
  const AppNotification({
    required this.id,
    required this.category,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
    this.orderId,
    this.orderNumber,
  });

  final int id;
  final String category;
  final String title;
  final String body;
  final bool isRead;
  final String createdAt;
  final int? orderId;
  final String? orderNumber;

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: JsonRead.integer(json['id']),
      category: JsonRead.text(json['category']),
      title: JsonRead.text(json['title']),
      body: JsonRead.text(json['body']),
      isRead: JsonRead.flag(json['is_read']),
      createdAt: JsonRead.text(json['created_at']),
      orderId: JsonRead.integerOrNull(json['order']),
      orderNumber: json['order_number']?.toString(),
    );
  }
}
