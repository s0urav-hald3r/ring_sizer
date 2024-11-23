import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/controllers/onboarding_controller.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(children: [
            Image.asset(onboardingOne),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: size.width,
                child: Column(children: [
                  Text(
                    'Welcome! Ring Sizers',
                    style: GoogleFonts.lora(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Discover your Ring Size',
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 40),
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
                        'Start Now',
                        style: GoogleFonts.lora(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: textColor,
                        ),
                      ),
                      onPressed: () {
                        OnboardingController.instance.pageController
                            .animateToPage(
                          1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear,
                        );
                      },
                    ),
                  )
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
