import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/components/back_appbar.dart';

import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/config/navigation.dart';

class CardDemoPage extends StatelessWidget {
  const CardDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: BackAppBar(title: '', invertColor: true),
            ),
            Container(
              width: size.width,
              height: 180,
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Align to card',
                  style: GoogleFonts.lora(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(children: [
                SizedBox(
                  width: size.width,
                  child: Stack(children: [
                    Transform.translate(
                      offset: Offset((size.width / 2) - 60, 60),
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
                                dashPattern: const [5, 5],
                                borderType: BorderType.Circle,
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
                              InkWell(
                                onTap: () {
                                  NavigatorKey.pop();
                                },
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(twoDIcon),
                                  ),
                                ),
                              ),
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
                                    child: SvgPicture.asset(infoIcon),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
