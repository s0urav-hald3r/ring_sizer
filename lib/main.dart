import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/config/navigation.dart';
import 'package:ring_sizer/config/store_config.dart';
import 'package:ring_sizer/controllers/converter_controller.dart';
import 'package:ring_sizer/controllers/onboarding_controller.dart';
import 'package:ring_sizer/controllers/ring_controller.dart';
import 'package:ring_sizer/controllers/settings_controller.dart';
import 'package:ring_sizer/utils/local_storage.dart';
import 'package:ring_sizer/views/navbar_page.dart';
import 'package:ring_sizer/views/onboarding_page.dart';

Future<void> _configureSDK() async {
  // Enable debug logs before calling `configure`.
  if (kReleaseMode) {
    await Purchases.setLogLevel(LogLevel.info);
  } else {
    await Purchases.setLogLevel(LogLevel.debug);
  }

  PurchasesConfiguration configuration;

  configuration = PurchasesConfiguration(StoreConfig.instance.apiKey);

  await Purchases.configure(configuration);
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize storage
  await GetStorage.init();

  // Configure store for in-app purchase
  if (Platform.isIOS) {
    StoreConfig(
      store: Store.appStore,
      apiKey: appleApiKey,
    );
  }

  await _configureSDK();

  // Injecting dependencies
  Get.lazyPut(() => OnboardingController());
  Get.lazyPut(() => RingController());
  Get.lazyPut(() => ConverterController());
  Get.put(SettingsController());

  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            side: const BorderSide(color: primaryColor),
            minimumSize: Size.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      navigatorKey: NavigatorKey.navigatorKey,
      home: LocalStorage.getData(isOnboardingDone, KeyType.BOOL)
          ? const NavBarPage()
          : const OnboardingPage(),
    );
  }
}
