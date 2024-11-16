import 'package:get/get.dart';

class CountryController extends GetxController {
  static CountryController get instance => Get.find();

  // Variables
  final RxInt _highlightedIndex = 0.obs;

  // Getters
  int get highlightedIndex => _highlightedIndex.value;

  // Setters
  set highlightedIndex(int index) => _highlightedIndex.value = index;
}
