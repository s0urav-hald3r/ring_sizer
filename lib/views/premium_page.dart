import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:ring_sizer/components/ad_section.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/config/navigation.dart';
import 'package:ring_sizer/controllers/settings_controller.dart';
import 'package:ring_sizer/utils/local_storage.dart';
import 'package:ring_sizer/views/navbar_page.dart';
import 'package:url_launcher/url_launcher.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = SettingsController.instance;

    StoreProduct weekly = controller.storeProduct
        .firstWhere((element) => element.identifier == weeklyPlan);

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Obx(() {
          return SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(children: [
              Image.asset(premiumPage),
              Positioned(
                bottom: 20 + MediaQuery.of(context).padding.bottom,
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
                          text: '${weekly.priceString}/week',
                          style: GoogleFonts.raleway(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        )
                      ]),
                    ),
                    const SizedBox(height: 15),
                    Obx(
                      () => Container(
                        width: size.width,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: elevated,
                        ),
                        child: ElevatedButton(
                          child: Text(
                            controller.ifPremium ? 'Subscribed' : 'Continue ≻',
                            style: GoogleFonts.lora(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: textColor,
                            ),
                          ),
                          onPressed: () {
                            if (controller.ifPremium) {
                              null;
                            } else {
                              controller.purchaseProduct(weekly);
                            }
                          },
                        ),
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
                            onTap: () async {
                              if (Get.currentRoute == '/') {
                                await LocalStorage.addData(
                                    isOnboardingDone, true);
                                NavigatorKey.pushReplacement(
                                    const NavBarPage());
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
                                'Limited Access',
                                style: GoogleFonts.lora(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: textColor.withOpacity(.5),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              Uri uri = Uri.parse(privacyPolicy);
                              if (!await launchUrl(
                                uri,
                                mode: LaunchMode.externalApplication,
                              )) {
                                throw Exception('Could not launch $uri');
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 27.5),
                              padding: const EdgeInsets.only(bottom: 1),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: primaryColor),
                                ),
                              ),
                              child: Text(
                                'Privacy Policy',
                                style: GoogleFonts.lora(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: textColor.withOpacity(.5),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              Uri uri = Uri.parse(termsOfUse);
                              if (!await launchUrl(
                                uri,
                                mode: LaunchMode.externalApplication,
                              )) {
                                throw Exception('Could not launch $uri');
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 27.5),
                              padding: const EdgeInsets.only(bottom: 1),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: primaryColor),
                                ),
                              ),
                              child: Text(
                                'Terms of Use',
                                style: GoogleFonts.lora(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: textColor.withOpacity(.5),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ]),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top,
                right: 0,
                child: InkWell(
                  onTap: () {
                    controller.restorePurchases();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 27.5),
                    padding: const EdgeInsets.only(bottom: 1),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: primaryColor),
                      ),
                    ),
                    child: Text(
                      'Restore',
                      style: GoogleFonts.lora(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: textColor.withOpacity(.5),
                      ),
                    ),
                  ),
                ),
              ),
              if (controller.isLoading)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black38,
                  child: const Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
            ]),
          );
        }),
      ),
    );
  }
}
