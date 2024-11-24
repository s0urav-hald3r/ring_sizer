import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/config/navigation.dart';
import 'package:ring_sizer/controllers/converter_controller.dart';
import 'package:ring_sizer/controllers/onboarding_controller.dart';
import 'package:ring_sizer/controllers/ring_controller.dart';

class GetRingSize extends StatelessWidget {
  const GetRingSize({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = RingController.instance;
    final converterController = ConverterController.instance;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: ClipPath(
        clipper: GetSizeClipper(),
        child: Container(
          width: size.width,
          height: 514,
          color: primaryColor,
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const SizedBox(height: 25),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const SizedBox(width: 15, height: 15),
              Text(
                'Your Ring Sizes',
                style: GoogleFonts.lora(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                  letterSpacing: -1,
                ),
              ),
              InkWell(
                onTap: () => NavigatorKey.pop(),
                child: SizedBox(
                  width: 15,
                  height: 15,
                  child: SvgPicture.asset(
                    crossIcon,
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 30),
            Stack(alignment: Alignment.center, children: [
              Image.asset(
                diamondRing,
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    controller.getUSFirstValue(),
                    style: GoogleFonts.raleway(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  if (controller.isUSFloatValue()) ...[
                    const SizedBox(width: 2.5),
                    Text(
                      controller.getUSSecondValue(),
                      style: GoogleFonts.raleway(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: secondaryColor,
                        height: -1, // Adjust this value
                      ),
                    ),
                  ]
                ]),
              )
            ]),
            const SizedBox(height: 30),
            Container(
              width: size.width,
              height: 75,
              padding: const EdgeInsets.all(13.5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(children: [
                      Text(
                        US,
                        style: GoogleFonts.lora(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        controller.getUSValue(),
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                    ]),
                    Column(children: [
                      Text(
                        AUUK,
                        style: GoogleFonts.lora(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        controller.getUKValue(),
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                    ]),
                    Column(children: [
                      Text(
                        'Size/In',
                        style: GoogleFonts.lora(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        controller.getInch(),
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                    ]),
                    Column(children: [
                      Text(
                        'CM',
                        style: GoogleFonts.lora(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        controller.getCemi(),
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                    ]),
                  ]),
            ),
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                height: 50,
                width: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: secondaryColor),
                child: ElevatedButton(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(saveIcon),
                        const SizedBox(width: 10),
                        Text(
                          'Save',
                          style: GoogleFonts.lora(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ]),
                  onPressed: () {
                    controller.addRing();
                  },
                ),
              ),
              Container(
                height: 50,
                width: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: secondaryColor),
                child: ElevatedButton(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(convertIcon),
                        const SizedBox(width: 10),
                        Text(
                          'Convert',
                          style: GoogleFonts.lora(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ]),
                  onPressed: () {
                    NavigatorKey.pop();
                    converterController.from = US;
                    converterController.to = AUUK;
                    converterController.ringSizeList = converterController
                        .ringChart
                        .map((ring) => ring[1].toString())
                        .toList();
                    converterController.selectedSize =
                        controller.ringChart[controller.currentValue][1];

                    Future.delayed(const Duration(milliseconds: 500),
                        () => OnboardingController.instance.screenIndex = 2);
                  },
                ),
              ),
            ])
          ]),
        ),
      ),
    );
  }
}

class GetSizeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height * 0.1);

    path.quadraticBezierTo(size.width * 0.015, size.height * 0.05,
        size.width * 0.08, size.height * 0.04);
    path.quadraticBezierTo(size.width * 0.35, 0, size.width * 0.5, 0);

    path.quadraticBezierTo(
        size.width * 0.65, 0, size.width * 0.92, size.height * 0.04);
    path.quadraticBezierTo(
        size.width * 0.985, size.height * 0.05, size.width, size.height * 0.1);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
