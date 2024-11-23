import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  // Variables
  final RxInt _highlightedIndex = 0.obs;
  final RxInt _screenIndex = 0.obs;

  // Getters
  int get highlightedIndex => _highlightedIndex.value;
  int get screenIndex => _screenIndex.value;

  // Setters
  set highlightedIndex(int index) => _highlightedIndex.value = index;
  set screenIndex(int index) => _screenIndex.value = index;
}
