import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/config/navigation.dart';

class GetRingSize extends StatelessWidget {
  const GetRingSize({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    '5',
                    style: GoogleFonts.raleway(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(width: 2.5),
                  Text(
                    '1/2',
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: secondaryColor,
                      height: -1, // Adjust this value
                    ),
                  ),
                ]),
              )
            ]),
            const SizedBox(height: 30),
            Container(
              width: size.width,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
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
                  child: Row(children: [
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
                  onPressed: () {},
                ),
              ),
              Container(
                height: 50,
                width: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: secondaryColor),
                child: ElevatedButton(
                  child: Row(children: [
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
                  onPressed: () {},
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

    path.moveTo(0, size.height * 0.15);

    path.quadraticBezierTo(size.width * 0.015, size.height * 0.1,
        size.width * 0.08, size.height * 0.08);
    path.quadraticBezierTo(size.width * 0.35, 0, size.width * 0.5, 0);

    path.quadraticBezierTo(
        size.width * 0.65, 0, size.width * 0.92, size.height * 0.08);
    path.quadraticBezierTo(
        size.width * 0.985, size.height * 0.1, size.width, size.height * 0.15);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
