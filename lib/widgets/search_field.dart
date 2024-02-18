import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/courseapi_service.dart';

class SearchBox extends ConsumerWidget {
  const SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AspectRatio(
      aspectRatio: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: ShapeDecoration(
            color: const Color(0xFF5451F1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: TextField(
          onChanged: (value) {
            ref.watch(searchQuery.notifier)
                .update((state) => value.toLowerCase());
          },
          style: GoogleFonts.openSans(
              color: const Color.fromRGBO(190, 190, 190, 1), fontSize: 16, height: 1.3),
          cursorColor: Colors.white,
          cursorOpacityAnimates: true,
          decoration: InputDecoration(
              disabledBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: "Search.....",
              hintStyle:
              GoogleFonts.openSans(color: const Color.fromRGBO(192, 192, 192, 1), fontSize: 16)),
        ),
      ),
    );
  }
}
