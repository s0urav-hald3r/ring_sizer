import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/utils/local_storage.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    countryName = LocalStorage.getData(storeCountryName, KeyType.STR);
    debugPrint('countryName: $countryName');
    ifPremium = LocalStorage.getData(isPremium, KeyType.BOOL);
    debugPrint('ifPremium: $ifPremium');
    fetchProducts();
  }

  // Variables
  final RxString _countryName = ''.obs;
  final RxBool _ifPremium = false.obs;
  final RxBool _isLoading = false.obs;

  final RxList<StoreProduct> _storeProduct = <StoreProduct>[].obs;

  // Getters
  String get countryName => _countryName.value;
  bool get ifPremium => _ifPremium.value;
  bool get isLoading => _isLoading.value;

  List get storeProduct => _storeProduct;

  // Setters
  set countryName(String value) => _countryName.value = value;
  set ifPremium(value) => _ifPremium.value = value;
  set isLoading(value) => _isLoading.value = value;

  set storeProduct(value) => _storeProduct.value = value;

  // Functions
  Future fetchProducts() async {
    try {
      final offerings = await Purchases.getOfferings();
      Offering? offering = offerings.current;
      if (offering != null) {
        // Look for the package with a trial period
        Package? weeklyPlan = offering.getPackage('\$rc_weekly');
        debugPrint('weeklyPlan: $weeklyPlan');

        if (weeklyPlan != null) {
          StoreProduct storeProduct = weeklyPlan.storeProduct;
          _storeProduct.add(storeProduct);

          debugPrint(
              'Free Product title: ${storeProduct.introductoryPrice?.price}');
          debugPrint(
              'Free Product price: ${storeProduct.introductoryPrice?.priceString}');
          debugPrint(
              'Free Product duration: ${storeProduct.introductoryPrice?.period}'); // Should show 3 days
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future purchaseProduct(StoreProduct storeProduct) async {
    isLoading = true;
    try {
      final customerInfo = await Purchases.purchaseStoreProduct(storeProduct);

      // Access customer information to verify the active subscriptions
      if (customerInfo.activeSubscriptions.isNotEmpty) {
        debugPrint("User successfully subscribed with free trial!");
        ifPremium = true;
        LocalStorage.addData(isPremium, true);
        isLoading = false;
        Get.back();
        Get.snackbar('', '',
            icon: const Icon(Icons.done),
            shouldIconPulse: true,
            titleText: const Text(
              'Success',
              style: TextStyle(
                  fontSize: 16, color: textColor, fontWeight: FontWeight.bold),
            ),
            messageText: const Text(
              'Subscription purchase successfully !',
              style: TextStyle(fontSize: 14, color: textColor),
            ),
            backgroundColor: primaryColor,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        isLoading = false;
      }

      debugPrint('customerInfo while purchase: $customerInfo');
    } on PlatformException catch (e) {
      debugPrint('error: $e');
      isLoading = false;
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        debugPrint('PurchasesErrorCode.purchaseCancelledError');
      }
    }
  }

  Future restorePurchases() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 1));
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      debugPrint('customerInfo while restore: $customerInfo');

      // Check if the user has the required entitlement
      ifPremium = customerInfo.entitlements.active.containsKey(entitlementID);

      if (ifPremium) {
        isLoading = false;
        // Grant access to premium tracking features
        // (e.g., update UI or store the entitlement state locally)
        LocalStorage.addData(isPremium, true);
        Get.back();
        Get.snackbar('', '',
            icon: const Icon(Icons.done),
            shouldIconPulse: true,
            titleText: const Text(
              'Success',
              style: TextStyle(
                  fontSize: 16, color: textColor, fontWeight: FontWeight.bold),
            ),
            messageText: const Text(
              'Subscription restored successfully !',
              style: TextStyle(fontSize: 14, color: textColor),
            ),
            backgroundColor: primaryColor,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        isLoading = false;
        Get.snackbar('', '',
            icon: const Icon(Icons.error),
            shouldIconPulse: true,
            titleText: const Text(
              'Failed',
              style: TextStyle(
                  fontSize: 16, color: textColor, fontWeight: FontWeight.bold),
            ),
            messageText: const Text(
              'Subscription not found !',
              style: TextStyle(fontSize: 14, color: textColor),
            ),
            backgroundColor: primaryColor,
            snackPosition: SnackPosition.BOTTOM);
      }
    } on PlatformException catch (e) {
      isLoading = false;
      debugPrint('error: $e');
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.receiptAlreadyInUseError) {
        debugPrint('PurchasesErrorCode.receiptAlreadyInUseError');
      }
      if (errorCode == PurchasesErrorCode.missingReceiptFileError) {
        debugPrint('PurchasesErrorCode.missingReceiptFileError');
      }
    }
  }
}
