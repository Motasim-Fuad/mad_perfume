import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:madperfume/config/routes/app_routes.dart';
import 'package:madperfume/config/routes/main_page.dart';
import 'package:madperfume/core/config/localization/app_translations.dart';
import 'package:madperfume/core/di/injection.dart';
import 'package:madperfume/core/network/api_client.dart';
import 'package:madperfume/core/services/locale_service.dart';
import 'package:madperfume/core/services/session_store.dart';
import 'package:madperfume/core/services/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();
  final storage = StorageService(GetStorage());
  Get.put(storage, permanent: true);
  Get.put(ApiClient(), permanent: true);
  final localeService = await Get.putAsync(() => LocaleService(storage).init(), permanent: true);
  final session = Get.put(SessionStore(storage), permanent: true);
  session.load();
  InitialBinding().dependencies();
  runApp(MadPerfumeApp(locale: localeService.locale.value));
}

class MadPerfumeApp extends StatelessWidget {
  const MadPerfumeApp({super.key, required this.locale});

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MAD Perfume',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      translations: AppTranslations(),
      locale: locale,
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'SA'),
        Locale('he', 'IL'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 380),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.splash,
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(textScaler: media.textScaler.clamp(maxScaleFactor: 1.2)),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
