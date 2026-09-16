import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:madperfume/core/network/api_client.dart';
import 'package:madperfume/core/services/storage_service.dart';
import 'package:madperfume/core/storage/token_store.dart';
import 'package:madperfume/features/auth/data/auth_repository.dart';
import 'package:madperfume/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:madperfume/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:madperfume/features/catalog/data/catalog_repository.dart';
import 'package:madperfume/features/catalog/presentation/cubit/catalog_cubits.dart';
import 'package:madperfume/features/commerce/data/commerce_repository.dart';
import 'package:madperfume/features/commerce/presentation/cubit/checkout_cubit.dart';
import 'package:madperfume/features/home/presentation/cubit/home_cubit.dart';
import 'package:madperfume/features/loyalty/data/loyalty_repository.dart';
import 'package:madperfume/features/loyalty/presentation/cubit/loyalty_cubits.dart';
import 'package:madperfume/features/orders/data/reviewed_product_store.dart';
import 'package:madperfume/features/profile/presentation/cubit/profile_cubits.dart';

final sl = GetIt.instance;

void setupLocator() {
  if (sl.isRegistered<ApiClient>()) {
    return;
  }

  sl.registerLazySingleton(() => StorageService(GetStorage()));
  sl.registerLazySingleton(() => TokenStore(sl()));
  sl.registerLazySingleton(() => ApiClient(sl()));

  sl.registerLazySingleton(() => AuthRepository(sl(), sl()));
  sl.registerLazySingleton(() => CatalogRepository(sl()));
  sl.registerLazySingleton(() => CartRepository(sl()));
  sl.registerLazySingleton(() => OrderRepository(sl()));
  sl.registerLazySingleton(() => LoyaltyRepository(sl()));
  sl.registerLazySingleton(() => ReviewedProductStore(sl()));

  sl.registerLazySingleton(() => AuthCubit(sl(), sl()));
  sl.registerLazySingleton(() => CartCubit(sl()));

  sl.registerFactory(() => HomeCubit(sl()));
  sl.registerFactory(() => CategoryCubit(sl()));
  sl.registerFactory(() => SearchCubit(sl()));
  sl.registerFactory(() => LoyaltyCubit(sl()));
  sl.registerFactory(() => RewardsCubit(sl()));
  sl.registerFactory(() => HistoryCubit(sl()));
  sl.registerFactory(() => RedemptionsCubit(sl()));
  sl.registerFactory(() => NotificationsCubit(sl()));
  sl.registerFactory(() => ProfileHomeCubit(sl(), sl()));
  sl.registerFactory(() => SavedCubit(sl()));
  sl.registerFactory(() => BranchesCubit(sl()));
  sl.registerFactory(() => OrdersCubit(sl()));
  sl.registerFactory(() => PrefsCubit(sl()));
  sl.registerFactory(() => SecurityCubit(sl(), sl()));
  sl.registerFactory(
    () => CheckoutCubit(
      sl(),
      sl<CartCubit>(),
      sl(),
      sl<AuthCubit>().state.profile,
    ),
  );
  sl.registerFactory(
    () => EditProfileCubit(sl<AuthCubit>(), sl<AuthCubit>().state.profile!),
  );

  sl.registerFactoryParam<ProductListCubit, int, void>(
    (id, _) => ProductListCubit(sl(), id),
  );
  sl.registerFactoryParam<ProductDetailsCubit, int, void>(
    (id, _) => ProductDetailsCubit(sl(), sl<CartCubit>(), id),
  );
  sl.registerFactoryParam<OrderDetailCubit, int, void>(
    (id, _) => OrderDetailCubit(
      sl(),
      sl(),
      sl<AuthCubit>().state.profile?.id ?? 0,
      id,
    ),
  );
  sl.registerFactoryParam<RewardDetailCubit, int, void>(
    (id, _) => RewardDetailCubit(sl(), sl<AuthCubit>(), id),
  );
  sl.registerFactoryParam<BranchDetailCubit, int, void>(
    (id, _) => BranchDetailCubit(sl(), id),
  );
  sl.registerFactoryParam<WriteReviewCubit, int, void>(
    (id, _) => WriteReviewCubit(
      sl(),
      sl(),
      sl<AuthCubit>(),
      sl<AuthCubit>().state.profile?.id ?? 0,
      id,
    ),
  );
}
