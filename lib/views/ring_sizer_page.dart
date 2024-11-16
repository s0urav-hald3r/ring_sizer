import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/components/menu_appbar.dart';
import 'package:ring_sizer/components/ring_sizer_box.dart';
import 'package:ring_sizer/config/constants.dart';

class RingSizerPage extends StatelessWidget {
  const RingSizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: MenuAppBar(),
            ),
            const SizedBox(height: 20),
            Text(
              'Put the ring on the circle',
              textAlign: TextAlign.center,
              style: GoogleFonts.lora(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),
            const RingSizerBox()
          ]),
        ),
      ),
    );
  }
}
