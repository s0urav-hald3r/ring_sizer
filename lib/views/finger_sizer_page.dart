import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/components/back_appbar.dart';

import 'package:ring_sizer/components/semicircle_slider.dart';
import 'package:ring_sizer/config/constants.dart';

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
                    child: const Column(children: []),
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
