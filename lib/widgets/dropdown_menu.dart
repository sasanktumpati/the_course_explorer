import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DropDownMenu extends ConsumerStatefulWidget {
  const DropDownMenu({
    Key? key,
    required this.list,
    required this.hintText,
    required this.choiceProvider,
  }) : super(key: key);

  final StateProvider<String> choiceProvider;
  final List<String> list;
  final String hintText;

  @override
  _CustomDropDownMenuState createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends ConsumerState<DropDownMenu> {
  String? dropDownValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF5451F1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color(0xFFFFFFFF),
            ),
            iconSize: 20,
            isExpanded: true,
            value: dropDownValue,
            style: GoogleFonts.openSans(color: const Color(0xFFC0C0C0)),
            dropdownColor: const Color(0xFF5451F1),
            borderRadius: BorderRadius.circular(10),
            hint: Text(
              widget.hintText,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: GoogleFonts.openSans(color: const Color(0xFFC0C0C0)),
            ),
            items: [
              DropdownMenuItem<String>(
                value: '',
                child: const Text(
                  "Clear",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              ...widget.list.map<DropdownMenuItem<String>>((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, softWrap: false),
                );
              }).toList(),
            ],
            onChanged: (value) {
              setState(() {
                if (value == '') {
                  dropDownValue = null;
                } else {
                  dropDownValue = value;
                }
                ref
                    .watch(widget.choiceProvider.notifier)
                    .update((state) => value!);
              });
            },
          ),
        ),
      ),
    );
  }
}
