import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/config/navigation.dart';
import 'package:ring_sizer/views/settings_page.dart';

class SettingsAppbar extends StatelessWidget {
  final String title;
  const SettingsAppbar({super.key, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      InkWell(
        onTap: () {
          NavigatorKey.push(const SettingsPage());
        },
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primaryColor,
          ),
          child: Center(
            child: SvgPicture.asset(settingsIcon),
          ),
        ),
      ),
      Text(
        title,
        style: GoogleFonts.raleway(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: secondaryColor,
        ),
      ),
      const SizedBox(
        width: 45,
        height: 45,
      )
    ]);
  }
}
