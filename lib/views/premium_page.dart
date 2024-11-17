import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/components/ad_section.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/config/navigation.dart';
import 'package:ring_sizer/views/navbar_page.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(children: [
            Image.asset(premiumPage),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: size.width,
                child: Column(children: [
                  Text(
                    'Start Free Trial to Proceed\nWith Measuring',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lora(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const AdSection(),
                  const SizedBox(height: 30),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: '3 Days Free, Then ',
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                      TextSpan(
                        text: '₹299',
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      )
                    ]),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: size.width,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: elevated,
                    ),
                    child: ElevatedButton(
                      child: Text(
                        'Continue',
                        style: GoogleFonts.lora(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: textColor,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Cancel any time before the week',
                    style: GoogleFonts.lora(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: textColor.withOpacity(.5),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            if (Get.currentRoute == '/') {
                              NavigatorKey.pushReplacement(const NavBarPage());
                            } else {
                              NavigatorKey.pop();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 27.5),
                            padding: const EdgeInsets.only(bottom: 1),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: primaryColor),
                              ),
                            ),
                            child: Text(
                              'No payment Now',
                              style: GoogleFonts.lora(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: textColor.withOpacity(.5),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 27.5),
                          padding: const EdgeInsets.only(bottom: 1),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: primaryColor),
                            ),
                          ),
                          child: Text(
                            'Restore Purchase',
                            style: GoogleFonts.lora(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: textColor.withOpacity(.5),
                            ),
                          ),
                        ),
                      ]),
                  const SizedBox(height: 20),
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
