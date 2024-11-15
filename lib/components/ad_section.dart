import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/config/constants.dart';

class AdSection extends StatelessWidget {
  const AdSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Stack(children: [
        Positioned(
          left: -15,
          top: 5,
          child: DottedBorder(
            borderType: BorderType.RRect,
            color: secondaryColor,
            radius: const Radius.circular(100),
            child: Container(
              padding: const EdgeInsets.fromLTRB(40, 10, 25, 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: Text(
                '• Limitless Application Use',
                style: GoogleFonts.raleway(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: -15,
          top: 5,
          child: DottedBorder(
            borderType: BorderType.RRect,
            color: secondaryColor,
            radius: const Radius.circular(100),
            child: Container(
              padding: const EdgeInsets.fromLTRB(25, 10, 40, 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: Text(
                '• Ads Free Forever',
                style: GoogleFonts.raleway(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: -15,
          bottom: 5,
          child: DottedBorder(
            borderType: BorderType.RRect,
            color: secondaryColor,
            radius: const Radius.circular(100),
            child: Container(
              padding: const EdgeInsets.fromLTRB(40, 10, 15, 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: Text(
                '• Unlimited Measurement',
                style: GoogleFonts.raleway(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: -15,
          bottom: 5,
          child: DottedBorder(
            borderType: BorderType.RRect,
            color: secondaryColor,
            radius: const Radius.circular(100),
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 40, 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: Text(
                '• Finding Right Ring Size',
                style: GoogleFonts.raleway(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
