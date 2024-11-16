import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/components/back_appbar.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/config/navigation.dart';
import 'package:ring_sizer/controllers/settings_controller.dart';
import 'package:ring_sizer/views/premium_page.dart';
import 'package:ring_sizer/views/save_size_page.dart';

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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    menuOption(controller.countryName, () {}),
                    const Divider(height: 1, color: primaryColor),
                    menuOption('Save Size', () {
                      NavigatorKey.push(const SaveSizePage());
                    }),
                    const Divider(height: 1, color: primaryColor),
                    menuOption('Managing Subscriptions', () {
                      NavigatorKey.push(const PremiumPage());
                    }),
                    const Divider(height: 1, color: primaryColor),
                    menuOption('Contact Us', () {}),
                    const Divider(height: 1, color: primaryColor),
                    menuOption('Privacy Policy', () {}),
                    const Divider(height: 1, color: primaryColor),
                    menuOption('Terms of Use', () {}),
                  ]),
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
