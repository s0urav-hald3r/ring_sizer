import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/config/constants.dart';
import 'package:ring_sizer/config/navigation.dart';
import 'package:ring_sizer/controllers/navbar_controller.dart';
import 'package:ring_sizer/views/converter_page.dart';
import 'package:ring_sizer/views/finger_sizer_page.dart';
import 'package:ring_sizer/views/ring_sizer_page.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  final controller = NavBarController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Obx(() => _buildBody()),
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return [
      const RingSizerPage(),
      Container(),
      const ConverterPage(),
    ][controller.screenIndex];
  }

  Widget _buildBottomNavigationBar() {
    return CustomPaint(
      painter: BottomNavigationBarPainter(),
      child: const SizedBox(
        width: double.infinity,
        height: 110,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          NavBarItem(
            icon: navURingIcon,
            selectedIcon: navSRingIcon,
            title: 'Ring Sizer',
            index: 0,
          ),
          NavBarItem(
            icon: navUFingerIcon,
            selectedIcon: navSFingerIcon,
            title: 'Finger Sizer',
            index: 1,
          ),
          NavBarItem(
            icon: navUConverterIcon,
            selectedIcon: navSConverterIcon,
            title: 'Converter',
            index: 2,
          ),
        ]),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String icon;
  final String selectedIcon;
  final String title;
  final int index;
  const NavBarItem({
    super.key,
    required this.icon,
    required this.selectedIcon,
    required this.title,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final controller = NavBarController.instance;

    return InkWell(
      onTap: () {
        if (index == 1) {
          NavigatorKey.push(const FingerSizerPage());
          return;
        }
        controller.screenIndex = index;
      },
      child: Obx(
        () => Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          controller.screenIndex == index
              ? SvgPicture.asset(selectedIcon)
              : SvgPicture.asset(icon),
          const SizedBox(height: 5),
          Text(
            title,
            style: GoogleFonts.raleway(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color:
                  controller.screenIndex == index ? secondaryColor : textColor,
            ),
          )
        ]),
      ),
    );
  }
}

class BottomNavigationBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint()
      ..color = const Color(0xFFFAFAFA)
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    path.moveTo(0, size.height * 0.35);

    path.quadraticBezierTo(size.width * 0.015, size.height * 0.1,
        size.width * 0.08, size.height * 0.08);
    path.quadraticBezierTo(size.width * 0.35, 0, size.width * 0.5, 0);

    path.quadraticBezierTo(
        size.width * 0.65, 0, size.width * 0.92, size.height * 0.08);
    path.quadraticBezierTo(
        size.width * 0.985, size.height * 0.1, size.width, size.height * 0.35);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BottomNavigationBarPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(BottomNavigationBarPainter oldDelegate) => false;
}
