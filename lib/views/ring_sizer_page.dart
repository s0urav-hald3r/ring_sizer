import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/components/fine_tune_button.dart';
import 'package:ring_sizer/components/get_ring_size.dart';
import 'package:ring_sizer/components/menu_appbar.dart';
import 'package:ring_sizer/components/ring_sizer_box.dart';
import 'package:ring_sizer/components/semicircle_slider.dart';
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
            Column(
              children: [
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
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 10),
                const RingSizerBox(),
              ],
            ),
            Expanded(
              child: Stack(children: [
                Transform.translate(
                  offset: const Offset(0, -45),
                  child: ClipPath(
                    clipper: RingSizerClipper(),
                    child: Container(
                      color: primaryColor,
                      width: size.width,
                      child: Column(children: [
                        const SizedBox(height: 90),
                        Text(
                          'Use the slider to choose the size',
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: secondaryColor,
                          ),
                        ),
                        const SizedBox(height: 25),
                        const FineTuneButton(),
                        const SizedBox(height: 25),
                        Container(
                          width: size.width,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: elevated,
                          ),
                          child: ElevatedButton(
                            child: Text(
                              'Get the Ring Size',
                              style: GoogleFonts.lora(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: textColor,
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  barrierColor: Colors.white10,
                                  isDismissible: false,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return const GetRingSize();
                                  });
                            },
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -45),
                  child: SemiCircleSlider(
                    initialValue: 12,
                    divisions: 20,
                    onChanged: (value) => debugPrint('value: $value'),
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class RingSizerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.quadraticBezierTo(size.width * 0.5, size.height * 0.33, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
