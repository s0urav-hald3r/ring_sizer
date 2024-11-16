import 'package:get/get.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/utils/local_storage.dart';

class SettingsController extends GetxController {
  static SettingsController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    countryName = LocalStorage.getData(storeCountryName, KeyType.STR);
  }

  // Variables
  final RxString _countryName = ''.obs;

  // Getters
  String get countryName => _countryName.value;

  // Setters
  set countryName(String value) => _countryName.value = value;
}
