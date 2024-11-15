import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/config/constants.dart';

class ConverterSection extends StatelessWidget {
  const ConverterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        width: 130,
        padding: const EdgeInsets.only(bottom: 1),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: secondaryColor.withOpacity(.5),
            ),
          ),
        ),
        child: Text(
          'US',
          style: GoogleFonts.montaga(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: textColor.withOpacity(.5),
          ),
        ),
      ),
      SvgPicture.asset(exchangeIcon),
      Container(
        width: 130,
        padding: const EdgeInsets.only(bottom: 1),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: secondaryColor.withOpacity(.5),
            ),
          ),
        ),
        child: Text(
          'AU/UK',
          style: GoogleFonts.montaga(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: textColor.withOpacity(.5),
          ),
        ),
      ),
    ]);
  }
}
