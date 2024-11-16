import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/controllers/country_controller.dart';
import 'package:ring_sizer/country_data.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({super.key});

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  final ScrollController _scrollController = ScrollController();
  final controller = CountryController.instance;

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
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
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
          child: Column(children: [
            const SizedBox(height: 40),
            Text(
              'Choose Your Country',
              style: GoogleFonts.lora(
                fontSize: 24,
                color: textColor,
                fontWeight: FontWeight.w400,
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
        ),
      ),
    );
  }
}
