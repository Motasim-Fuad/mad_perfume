import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/core/error/api_exception.dart';
import 'package:madperfume/core/models/loyalty_models.dart';
import 'package:madperfume/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:madperfume/features/loyalty/data/loyalty_repository.dart';

class LoyaltyState extends Equatable {
  const LoyaltyState({
    this.summary = LoyaltySummary.empty,
    this.loading = true,
    this.error = '',
  });

  final LoyaltySummary summary;
  final bool loading;
  final String error;

  @override
  List<Object?> get props => [summary, loading, error];
}

class LoyaltyCubit extends Cubit<LoyaltyState> {
  LoyaltyCubit(this._repository) : super(const LoyaltyState()) {
    instance = this;
  }

  static LoyaltyCubit? instance;

  final LoyaltyRepository _repository;

  Future<void> load() async {
    emit(const LoyaltyState(loading: true));
    try {
      final summary = await _repository.summary();
      emit(LoyaltyState(summary: summary, loading: false));
    } on ApiException catch (error) {
      emit(LoyaltyState(loading: false, error: error.message));
    }
  }

  void openEarn() => Get.toNamed(AppRoutes.earnPoints);
  void openRewards() => Get.toNamed(AppRoutes.rewards);
  void openRedeemed() => Get.toNamed(AppRoutes.redeemedRewards);
  void openHistory() => Get.toNamed(AppRoutes.pointsHistory);

  @override
  Future<void> close() {
    if (identical(instance, this)) {
      instance = null;
    }
    return super.close();
  }
}

class RewardsState extends Equatable {
  const RewardsState({
    this.items = const [],
    this.loading = true,
    this.error = '',
  });

  final List<RewardModel> items;
  final bool loading;
  final String error;

  @override
  List<Object?> get props => [items, loading, error];
}

class RewardsCubit extends Cubit<RewardsState> {
  RewardsCubit(this._repository) : super(const RewardsState());

  final LoyaltyRepository _repository;

  Future<void> load() async {
    emit(const RewardsState(loading: true));
    try {
      final items = await _repository.rewards();
      emit(RewardsState(items: items, loading: false));
    } on ApiException catch (error) {
      emit(RewardsState(loading: false, error: error.message));
    }
  }

  void open(int id) => Get.toNamed(AppRoutes.rewardDetails, arguments: id);
}

class RewardDetailState extends Equatable {
  const RewardDetailState({
    this.reward,
    this.loading = true,
    this.busy = false,
    this.error = '',
    this.actionError = '',
    this.voucher,
  });

  final RewardModel? reward;
  final bool loading;
  final bool busy;
  final String error;
  final String actionError;
  final RedemptionModel? voucher;

  @override
  List<Object?> get props => [
    reward,
    loading,
    busy,
    error,
    actionError,
    voucher,
  ];
}

class RewardDetailCubit extends Cubit<RewardDetailState> {
  RewardDetailCubit(this._repository, this._auth, this.rewardId)
    : super(const RewardDetailState());

  final LoyaltyRepository _repository;
  final AuthCubit _auth;
  final int rewardId;

  Future<void> load() async {
    emit(const RewardDetailState(loading: true));
    try {
      final reward = await _repository.reward(rewardId);
      emit(RewardDetailState(reward: reward, loading: false));
    } on ApiException catch (error) {
      emit(RewardDetailState(loading: false, error: error.message));
    }
  }

  Future<void> redeem() async {
    final reward = state.reward;
    if (reward == null || !reward.canRedeem) {
      return;
    }
    emit(
      RewardDetailState(
        reward: reward,
        loading: false,
        busy: true,
        actionError: '',
      ),
    );
    try {
      final voucher = await _repository.redeem(reward.id);
      await _auth.refreshProfile();
      await LoyaltyCubit.instance?.load();
      emit(
        RewardDetailState(
          reward: reward.copyCanRedeem(false),
          loading: false,
          voucher: voucher,
          actionError: '',
        ),
      );
    } on ApiException catch (error) {
      emit(
        RewardDetailState(
          reward: reward,
          loading: false,
          actionError: error.message,
        ),
      );
    }
  }
}

extension on RewardModel {
  RewardModel copyCanRedeem(bool value) {
    return RewardModel(
      id: id,
      name: name,
      pointsRequired: pointsRequired,
      category: category,
      eligibility: eligibility,
      description: description,
      imageUrl: imageUrl,
      canRedeem: value,
    );
  }
}

class HistoryState extends Equatable {
  const HistoryState({
    this.items = const [],
    this.filter = 'all',
    this.loading = true,
    this.error = '',
  });

  final List<PointsTransaction> items;
  final String filter;
  final bool loading;
  final String error;

  @override
  List<Object?> get props => [items, filter, loading, error];
}

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(this._repository) : super(const HistoryState());

  final LoyaltyRepository _repository;

  Future<void> load({String filter = 'all'}) async {
    emit(HistoryState(filter: filter, loading: true));
    try {
      final kind = filter == 'all'
          ? null
          : (filter == 'spent' ? 'redeemed' : 'earned');
      final page = await _repository.transactions(kind: kind);
      emit(HistoryState(items: page.results, filter: filter, loading: false));
    } on ApiException catch (error) {
      emit(HistoryState(filter: filter, loading: false, error: error.message));
    }
  }
}

class RedemptionsState extends Equatable {
  const RedemptionsState({
    this.items = const [],
    this.loading = true,
    this.error = '',
  });

  final List<RedemptionModel> items;
  final bool loading;
  final String error;

  @override
  List<Object?> get props => [items, loading, error];
}

class RedemptionsCubit extends Cubit<RedemptionsState> {
  RedemptionsCubit(this._repository) : super(const RedemptionsState());

  final LoyaltyRepository _repository;

  Future<void> load() async {
    emit(const RedemptionsState(loading: true));
    try {
      final page = await _repository.redemptions();
      emit(RedemptionsState(items: page.results, loading: false));
    } on ApiException catch (error) {
      emit(RedemptionsState(loading: false, error: error.message));
    }
  }
}

class NotificationsState extends Equatable {
  const NotificationsState({
    this.items = const [],
    this.unread = 0,
    this.loading = true,
    this.error = '',
    this.category,
  });

  final List<AppNotification> items;
  final int unread;
  final bool loading;
  final String error;
  final String? category;

  @override
  List<Object?> get props => [items, unread, loading, error, category];
}

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repository) : super(const NotificationsState());

  final LoyaltyRepository _repository;

  Future<void> load({String? category}) async {
    emit(NotificationsState(loading: true, category: category));
    try {
      final page = await _repository.notifications(category: category);
      final unread = await _repository.unreadCount();
      emit(
        NotificationsState(
          items: page.results,
          unread: unread,
          loading: false,
          category: category,
        ),
      );
    } on ApiException catch (error) {
      emit(NotificationsState(loading: false, error: error.message));
    }
  }

  Future<void> open(AppNotification item) async {
    if (!item.isRead) {
      await _repository.markRead(item.id);
      await load(category: state.category);
    }
    if (item.orderId != null) {
      Get.toNamed(AppRoutes.orderTracking, arguments: item.orderId);
    }
  }
}
