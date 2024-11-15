import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/components/back_appbar.dart';
import 'package:ring_sizer/config/constants.dart';

class SaveSizePage extends StatelessWidget {
  const SaveSizePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            const SizedBox(height: 10),
            const BackAppBar(title: 'Save Size'),
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 1,
                      color: primaryColor,
                    );
                  },
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${index * .75} mm',
                              style: GoogleFonts.lora(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'lorem ipsume the dummy font family to are font family the dum.',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: secondaryColor,
                              ),
                            ),
                          ]),
                    );
                  }),
            )
          ]),
        ),
      ),
    );
  }
}
