import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/components/converter_clipper.dart';
import 'package:ring_sizer/components/converter_painter.dart';
import 'package:ring_sizer/components/converter_section.dart';
import 'package:ring_sizer/components/custom_drop_down_button.dart';
import 'package:ring_sizer/components/settings_appbar.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/controllers/converter_controller.dart';

class ConverterPage extends StatelessWidget {
  const ConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = ConverterController.instance;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                const SizedBox(height: 10),
                const SettingsAppbar(title: 'Convert'),
                const SizedBox(height: 30),
                Text(
                  'Select a ring size you\nwant to convert',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                    letterSpacing: -1,
                  ),
                ),
              ]),
            ),
            Expanded(
              child: CustomPaint(
                painter: ConverterPainter(),
                child: ClipPath(
                  clipper: ConverterClipper(),
                  child: Container(
                    width: size.width,
                    color: primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(children: [
                      const SizedBox(height: 100),
                      Obx(
                        () => CustomDropDownButton(
                          items: controller.ringSizeList,
                          selectedValue: controller.selectedSize,
                          onChanged: (value) {
                            controller.selectedSize = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      const ConverterSection(),
                      const SizedBox(height: 40),
                      Container(
                        width: size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: elevated,
                        ),
                        child: ElevatedButton(
                          child: Text(
                            'Convert',
                            style: GoogleFonts.lora(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: textColor,
                            ),
                          ),
                          onPressed: () {
                            controller.convertRingSize();
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
                      Obx(
                        () => Container(
                          height: 85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: secondaryColor),
                          ),
                          child: Center(
                            child:
                                Row(mainAxisSize: MainAxisSize.min, children: [
                              Text(
                                controller.getRingFirstValue(),
                                style: GoogleFonts.raleway(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              if (controller.isRingFloatValue()) ...[
                                const SizedBox(width: 2.5),
                                Text(
                                  controller.getRingSecondValue()!,
                                  style: GoogleFonts.raleway(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: secondaryColor,
                                    height: -1, // Adjust this value
                                  ),
                                ),
                              ]
                            ]),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
