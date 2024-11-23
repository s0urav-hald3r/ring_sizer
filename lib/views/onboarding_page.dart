import 'package:flutter/material.dart';
import 'package:ring_sizer/controllers/onboarding_controller.dart';
import 'package:ring_sizer/views/country_page.dart';
import 'package:ring_sizer/views/premium_page.dart';
import 'package:ring_sizer/views/welcome_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: PageView(
            controller: OnboardingController.instance.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              WelcomePage(),
              CountryPage(),
              PremiumPage(),
            ]),
      ),
    );
  }
}
