import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/components/back_appbar.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/config/navigation.dart';
import 'package:ring_sizer/controllers/settings_controller.dart';
import 'package:ring_sizer/views/country_page.dart';
import 'package:ring_sizer/views/premium_page.dart';
import 'package:ring_sizer/views/save_size_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = SettingsController.instance;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            const SizedBox(height: 10),
            const BackAppBar(title: 'Settings'),
            Expanded(
              child: Center(
                child: Obx(() {
                  return Text(
                    controller.ifPremium
                        ? 'Congratulations 🎉\nYou are Pro User'
                        : 'You are a Free User',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lora(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: secondaryColor,
                    ),
                  );
                }),
              ),
            ),
            Expanded(
              flex: 3,
              child: Obx(() {
                return Column(children: [
                  menuOption(controller.countryName, () {
                    NavigatorKey.push(const CountryPage());
                  }),
                  const Divider(height: 1, color: primaryColor),
                  menuOption('Saved Size', () {
                    NavigatorKey.push(const SaveSizePage());
                  }),
                  const Divider(height: 1, color: primaryColor),
                  if (!controller.ifPremium) ...[
                    menuOption('Managing Subscriptions', () {
                      NavigatorKey.push(const PremiumPage());
                    }),
                    const Divider(height: 1, color: primaryColor),
                  ],
                  menuOption('Contact Us', () async {
                    Uri uri = Uri.parse(support);
                    if (!await launchUrl(
                      uri,
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw Exception('Could not launch $uri');
                    }
                  }),
                  const Divider(height: 1, color: primaryColor),
                  menuOption('Privacy Policy', () async {
                    Uri uri = Uri.parse(privacyPolicy);
                    if (!await launchUrl(
                      uri,
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw Exception('Could not launch $uri');
                    }
                  }),
                  const Divider(height: 1, color: primaryColor),
                  menuOption('Terms of Use', () async {
                    Uri uri = Uri.parse(termsOfUse);
                    if (!await launchUrl(
                      uri,
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw Exception('Could not launch $uri');
                    }
                  }),
                ]);
              }),
            )
          ]),
        ),
      ),
    );
  }

  Widget menuOption(String title, Function callBack) {
    return InkWell(
      onTap: () => callBack(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
