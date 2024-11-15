import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/components/converter_clipper.dart';
import 'package:ring_sizer/components/converter_painter.dart';
import 'package:ring_sizer/components/converter_section.dart';
import 'package:ring_sizer/components/settings_appbar.dart';
import 'package:ring_sizer/config/constants.dart';

class ConverterPage extends StatelessWidget {
  const ConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                      Container(
                        height: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: secondaryColor.withOpacity(.5),
                          ),
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
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        height: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: secondaryColor),
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
