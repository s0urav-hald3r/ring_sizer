import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/controllers/ring_controller.dart';

class RingSizerBox extends StatelessWidget {
  const RingSizerBox({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = RingController.instance;

    return Container(
      width: size.width,
      height: 325,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(netBackground), fit: BoxFit.cover),
      ),
      child: Obx(
        () => Stack(alignment: Alignment.center, children: [
          AnimatedContainer(
            width: controller.diameterInPx,
            height: controller.diameterInPx,
            duration: const Duration(milliseconds: 250),
            decoration: const BoxDecoration(
              gradient: elevated,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              plainRing,
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(right: controller.diameterInPx / 1.5),
              child: SvgPicture.asset(backIcon),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RotatedBox(
              quarterTurns: 2,
              child: Padding(
                padding: EdgeInsets.only(right: controller.diameterInPx / 1.5),
                child: SvgPicture.asset(backIcon),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RotatedBox(
              quarterTurns: 3,
              child: Padding(
                padding: EdgeInsets.only(right: controller.diameterInPx / 1.5),
                child: SvgPicture.asset(backIcon),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RotatedBox(
              quarterTurns: 1,
              child: Padding(
                padding: EdgeInsets.only(right: controller.diameterInPx / 1.5),
                child: SvgPicture.asset(backIcon),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
