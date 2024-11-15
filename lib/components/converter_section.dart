import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/controllers/converter_controller.dart';

class ConverterSection extends StatelessWidget {
  const ConverterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ConverterController.instance;

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
        child: Obx(
          () => Text(
            controller.to,
            style: GoogleFonts.montaga(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: textColor.withOpacity(.5),
            ),
          ),
        ),
      ),
      InkWell(
        onTap: () => controller.toggleVariable(),
        child: SvgPicture.asset(exchangeIcon),
      ),
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
        child: Obx(
          () => Text(
            controller.from,
            style: GoogleFonts.montaga(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: textColor.withOpacity(.5),
            ),
          ),
        ),
      ),
    ]);
  }
}
