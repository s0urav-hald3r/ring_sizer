import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/components/back_appbar.dart';

import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/config/navigation.dart';

class CardInfoPage extends StatelessWidget {
  const CardInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: false,
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            const SizedBox(height: 10),
            const BackAppBar(title: '', invertColor: true),
            const SizedBox(height: 50),
            Image.asset(cardHolder),
            Text(
              'Align to card center & Adjust Finger to match its size',
              style: GoogleFonts.lora(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'For better ring measurements usa a white background adjust finger to center',
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: elevated,
              ),
              child: ElevatedButton(
                child: Text(
                  'Okay',
                  style: GoogleFonts.lora(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
                onPressed: () {
                  NavigatorKey.pop();
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
