import 'package:candy_app/decoration.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class pickedDate extends StatefulWidget {
  const pickedDate({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<pickedDate> createState() => _pickedDateState();
}

class _pickedDateState extends State<pickedDate> {
  DateTime? _dataEntryDate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        child: InkWell(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2024),
              lastDate: DateTime(2027),
            );
            if (pickedDate != null) {
              setState(() {
                _dataEntryDate = pickedDate;
                widget.controller.text =
                    "${pickedDate.toLocal()}".split(' ')[0];
              });
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: 'Select Transaction Date',
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              filled: true,
              hintStyle:
                  textBlackMedium.copyWith(color: lightGrey, fontSize: 12),
              fillColor: lightWhite,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _dataEntryDate == null
                      ? 'Select Transaction Date'
                      : widget.controller.text,
                  style: textBlackMedium.copyWith(
                      // Apply lightGrey if _dataEntryDate is null (for the placeholder text)
                      // Otherwise, apply your desired color (e.g., Colors.black, Colors.blue, etc.)
                      color: _dataEntryDate == null
                          ? lightGrey
                          : Colors
                              .black, // <-- Change Colors.black to your preferred color
                      fontSize: _dataEntryDate == null ? 12 : 13.5),
                ),
                // Text(
                //   _dataEntryDate == null
                //       ? 'Select Transaction Date'
                //       : widget.controller.text,
                //   style:

                //       textBlackMedium.copyWith(color: lightGrey, fontSize: 12),
                // ),
                const Icon(FontAwesomeIcons.calendarDay),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
