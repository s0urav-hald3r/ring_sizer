import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/components/triangle_painter.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/controllers/onboarding_controller.dart';
import 'package:ring_sizer/country_data.dart';
import 'package:ring_sizer/utils/local_storage.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  final ScrollController _scrollController = ScrollController();
  final controller = OnboardingController.instance;
  Timer? _scrollEndTimer; // Timer to detect the end of scrolling

  @override
  void initState() {
    super.initState();
    // Assign unique GlobalKeys to all items in countryData
    for (int i = 0; i < countryData.length; i++) {
      countryData[i]['key'] = GlobalKey();
    }
    _scrollController.addListener(_onScroll);

    // Highlight the initial middle element
    WidgetsBinding.instance.addPostFrameCallback((_) {
      highlightInitialItem();
    });
  }

  void highlightInitialItem() {
    if (_scrollController.hasClients) {
      final double screenHeight = MediaQuery.of(context).size.height;
      final double middleOfScreen = screenHeight / 2;

      double closestDistance = double.infinity;
      int closestIndex = -1;

      // Find the child closest to the middle of the screen
      for (int index = 0; index < countryData.length; index++) {
        final GlobalKey key = countryData[index]['key'] as GlobalKey;
        final RenderBox? box =
            key.currentContext?.findRenderObject() as RenderBox?;

        if (box != null) {
          final Offset itemPosition = box.localToGlobal(Offset.zero);
          final double itemCenter = itemPosition.dy + (box.size.height / 2);

          final double distance = (itemCenter - middleOfScreen).abs();

          if (distance < closestDistance) {
            closestDistance = distance;
            closestIndex = index;
          }
        }
      }

      if (closestIndex != -1) {
        controller.highlightedIndex = closestIndex;
      }
    }
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      // Cancel any previous timer when scrolling happens
      _scrollEndTimer?.cancel();

      // Find the middle of the screen
      final double screenHeight = MediaQuery.of(context).size.height;
      final double middleOfScreen = screenHeight / 2;

      double closestDistance = double.infinity;
      int closestIndex = -1;

      // Iterate over each child to find the one closest to the middle
      for (int index = 0; index < countryData.length; index++) {
        final GlobalKey key = countryData[index]['key'] as GlobalKey;
        final RenderBox? box =
            key.currentContext?.findRenderObject() as RenderBox?;

        if (box != null) {
          // Position of item
          final Offset itemPosition = box.localToGlobal(Offset.zero);
          final double itemCenter = itemPosition.dy + (box.size.height / 2);

          final double distance = (itemCenter - middleOfScreen).abs();

          if (distance < closestDistance) {
            closestDistance = distance;
            closestIndex = index;
          }
        }
      }

      if (closestIndex != controller.highlightedIndex) {
        controller.highlightedIndex = closestIndex;
      }

      // Set a timer to check if scrolling has stopped
      _scrollEndTimer =
          Timer(const Duration(milliseconds: 100), _adjustScrollPosition);
    }
  }

  void _adjustScrollPosition() {
    // After scrolling has stopped, adjust the position of the selected item
    final double screenHeight = MediaQuery.of(context).size.height;
    final double middleOfScreen = screenHeight / 2;

    // Find the selected item
    final GlobalKey key =
        countryData[controller.highlightedIndex]['key'] as GlobalKey;
    final RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;

    if (box != null) {
      final Offset itemPosition = box.localToGlobal(Offset.zero);
      final double itemCenter = itemPosition.dy + (box.size.height / 2);
      final double offset = itemCenter - middleOfScreen;

      // Scroll to center the selected item
      if ((offset).abs() > 10) {
        _scrollController.animateTo(
          _scrollController.offset + offset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _scrollEndTimer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(children: [
            Column(children: [
              const SizedBox(height: 40),
              Text(
                'Choose Your Country',
                style: GoogleFonts.lora(
                  fontSize: 24,
                  color: textColor,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Select your country to use the relevant measurement system',
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  fontSize: 16,
                  color: secondaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return Container(
                      key: countryData[index]['key'],
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: textColor.withOpacity(.025),
                          child: Text(
                            countryData[index]['flag']!,
                            style: GoogleFonts.raleway(
                              fontSize: 40,
                              color: textColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        title: Obx(
                          () => Text(
                            countryData[index]['name']!,
                            style: GoogleFonts.raleway(
                              fontSize: 16,
                              color: controller.highlightedIndex == index
                                  ? textColor
                                  : textColor.withOpacity(.5),
                              fontWeight: controller.highlightedIndex == index
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1,
                      indent: 25,
                      endIndent: 25,
                      color: secondaryColor.withOpacity(.1),
                    );
                  },
                  itemCount: countryData.length,
                ),
              )
            ]),
            Positioned(
              right: 0,
              top: (size.height / 2) - MediaQuery.of(context).padding.top - 10,
              child: RotatedBox(
                quarterTurns: 3,
                child: CustomPaint(
                  size: const Size(20, 20), // Width and height of the triangle
                  painter: TrianglePainter(),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: size.width,
                height: 50,
                margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: elevated,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 50,
                          spreadRadius: 25,
                          offset: Offset(0, -10)),
                    ]),
                child: ElevatedButton(
                  child: Text(
                    'Continue',
                    style: GoogleFonts.lora(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    ),
                  ),
                  onPressed: () async {
                    final value =
                        countryData[controller.highlightedIndex]['name'];
                    await LocalStorage.addData(storeCountryName, value);

                    OnboardingController.instance.pageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.fastEaseInToSlowEaseOut,
                    );
                  },
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
