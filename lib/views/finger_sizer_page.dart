import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/components/back_appbar.dart';

import 'package:ring_sizer/components/semicircle_slider.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/config/navigation.dart';
import 'package:ring_sizer/views/card_demo_page.dart';

class FingerSizerPage extends StatelessWidget {
  const FingerSizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(children: [
            Column(
              children: [
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: BackAppBar(title: 'Finger Sizer'),
                ),
                const SizedBox(height: 30),
                Text(
                  'Determine ring size by finger',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Place your finger and adjust the slider\nto match its size',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: secondaryColor,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            Expanded(
              child: Stack(children: [
                ClipPath(
                  clipper: FingerSizerClipper(),
                  child: Container(
                    color: primaryColor,
                    width: size.width,
                    child: Stack(children: [
                      Transform.translate(
                        offset: Offset((size.width / 2) - 60, 120),
                        child: Stack(
                            alignment: Alignment.topCenter,
                            clipBehavior: Clip.none,
                            children: [
                              DottedBorder(
                                borderType: BorderType.RRect,
                                dashPattern: const [5, 5],
                                color: secondaryColor,
                                radius: const Radius.circular(100),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  width: 120,
                                  height: 600,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                child: DottedBorder(
                                  borderType: BorderType.Circle,
                                  dashPattern: const [5, 5],
                                  color: secondaryColor,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    width: 80,
                                    height: 80,
                                    decoration: const BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                              // Positioned(
                              //   top: -200,
                              //   child: Transform.scale(
                              //     scale: 0.8,
                              //     child: Image.asset(hand),
                              //   ),
                              // )
                            ]),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: size.width,
                          padding: EdgeInsets.fromLTRB(
                            40,
                            0,
                            40,
                            MediaQuery.of(context).padding.bottom,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  InkWell(
                                    onTap: () {
                                      NavigatorKey.push(const CardDemoPage());
                                    },
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(threeDIcon),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(navSFingerIcon),
                                      ),
                                    ),
                                  ),
                                ]),
                                Column(children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(minusIcon),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(addIcon),
                                      ),
                                    ),
                                  ),
                                ]),
                              ]),
                        ),
                      ),
                    ]),
                  ),
                ),
                SemiCircleSlider(
                  initialValue: 12,
                  divisions: 20,
                  onChanged: (value) => debugPrint('value: $value'),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class FingerSizerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.quadraticBezierTo(size.width * 0.5, size.height * 0.18, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
