import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ring_sizer/config/constants.dart';

class RingSizerBox extends StatelessWidget {
  const RingSizerBox({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: 350,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(netBackground),
        ),
      ),
      child: Stack(alignment: Alignment.center, children: [
        AnimatedContainer(
          width: 160,
          height: 160,
          duration: const Duration(milliseconds: 250),
          child: Image.asset(
            plainRing,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          width: 130,
          height: 130,
          child: Stack(children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              child: Container(
                width: 130,
                height: 130,
                decoration: const BoxDecoration(
                  gradient: elevated,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: SvgPicture.asset(backIcon),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: RotatedBox(
                quarterTurns: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: SvgPicture.asset(backIcon),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RotatedBox(
                quarterTurns: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: SvgPicture.asset(backIcon),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: RotatedBox(
                quarterTurns: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: SvgPicture.asset(backIcon),
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
