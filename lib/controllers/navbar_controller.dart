import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarController extends GetxController {
  static NavBarController get instance => Get.find();

  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  // * ---------------------------------/ Variable Start /------------------------------

  final RxInt _screenIndex = 0.obs;

  // * ---------------------------------/ Variable End /--------------------------------

  // ! ----------------------------------------------------------------------------------

  // * ---------------------------------/ Getter Start /------------------------------

  int get screenIndex => _screenIndex.value;

  // * ---------------------------------/ Getter End /--------------------------------

  // ! ----------------------------------------------------------------------------------

  // * ---------------------------------/ Setter Start /------------------------------

  set screenIndex(int index) => _screenIndex.value = index;

  // * ---------------------------------/ Setter End /--------------------------------

  // ! ----------------------------------------------------------------------------------
}
