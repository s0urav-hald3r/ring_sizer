import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/config/constants.dart';

class FineTuneButton extends StatelessWidget {
  const FineTuneButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
      const SizedBox(width: 20),
      Text(
        'Fine-tune',
        style: GoogleFonts.lora(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
      ),
      const SizedBox(width: 20),
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
    ]);
  }
}