import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/courseapi.dart';

class filteredlist extends StatelessWidget {
  const filteredlist({
    super.key,
    required List<CourseAPI> courseList,
    required this.index,
  }) : _courseList = courseList;

  final List<CourseAPI> _courseList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      borderOnForeground: false,
      color: const Color.fromRGBO(52, 152, 219, 0.5),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "Course Name\n",
                      style: GoogleFonts.openSans(
                          color: Colors.white54, fontSize: 10)),
                  TextSpan(
                      text: _courseList[index].courseName,
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          height: 1,
                          color: Colors.white70))
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Course Code   \n",
                            style: GoogleFonts.openSans(
                                fontSize: 10,
                                color: Colors.white54,
                                height: 3.5)),
                        TextSpan(
                            text: _courseList[index].courseCode,
                            style: GoogleFonts.openSans(
                                height: 0.5, color: Colors.white70)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Year    ",
                            style: GoogleFonts.openSans(
                              color: Colors.white54,
                              fontSize: 10,
                              height: 3.5,
                            )),
                        TextSpan(
                            text: _courseList[index].year,
                            style: GoogleFonts.openSans(color: Colors.white70)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            RichText(
                textAlign: TextAlign.left,
                text: TextSpan(children: [
                  TextSpan(
                      text: "Department\n",
                      style: GoogleFonts.openSans(
                          color: Colors.white54, fontSize: 10, height: 3.5)),
                  TextSpan(
                      text: _courseList[index].department.name,
                      style: GoogleFonts.openSans(
                          height: 0.5, color: Colors.white70))
                ]))
          ],
        ),
      ),
    );
  }
}
