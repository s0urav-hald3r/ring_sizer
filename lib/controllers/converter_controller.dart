import 'package:get/get.dart';

class ConverterController extends GetxController {
  static ConverterController get instance => Get.find();

  // Variables
  final RxString _to = 'US'.obs;
  final RxString _from = 'AU/UK'.obs;

  // Getters
  String get to => _to.value;
  String get from => _from.value;

  // Setters
  set to(String value) => _to.value = value;
  set from(String value) => _from.value = value;

  // Functions
  void toggleVariable() {
    String temp = to;
    to = from;
    from = temp;
  }
}
