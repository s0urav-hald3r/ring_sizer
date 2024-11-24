import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ring_sizer/config/constants.dart';

class CustomDropDownButton extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final Function onChanged;
  const CustomDropDownButton({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        items: items.map(
          (item) {
            String first = item.split(' ')[0];

            bool isfloat = item.split(' ').length > 1;
            String second = '';
            if (isfloat) {
              second = item.split(' ')[1];
            }

            return DropdownMenuItem<String>(
              value: item,
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(
                  first,
                  style: GoogleFonts.raleway(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
                if (isfloat) ...[
                  const SizedBox(width: 2.5),
                  Text(
                    second,
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: secondaryColor,
                      height: -1, // Adjust this value
                    ),
                  ),
                ]
              ]),
            );
          },
        ).toList(),
        value: selectedValue,
        onChanged: (value) {
          onChanged(value);
        },
        buttonStyleData: ButtonStyleData(
          height: 85,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(160, 18, 24, 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: secondaryColor.withOpacity(.5),
            ),
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.keyboard_arrow_down_rounded),
          iconSize: 24,
        ),
        dropdownStyleData: DropdownStyleData(
          offset: const Offset(0, -5),
          width: MediaQuery.of(context).size.width - 60,
          padding: const EdgeInsets.all(10),
          maxHeight: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          elevation: 1,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }
}
