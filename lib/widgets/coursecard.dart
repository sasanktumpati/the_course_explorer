import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/courseapi.dart';

class FilteredList extends StatelessWidget {
  const FilteredList({
    super.key,
    required List<CourseAPI> courseList,
    required this.index,
  }) : _courseList = courseList;

  final List<CourseAPI> _courseList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black,
      color: const Color.fromRGBO(10, 38, 61, 0.1),
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
                          color: const Color.fromRGBO(192, 192, 192, 1), fontSize: 16)),
                  TextSpan(
                      text: _courseList[index].courseName,
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          height: 1.5,
                          color:const Color.fromRGBO(190, 190, 190, 1)))
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
                                fontSize: 16,
                                color: const Color.fromRGBO(192, 192, 192, 1),
                                height: 3.5)),
                        TextSpan(
                            text: _courseList[index].courseCode,
                            style: GoogleFonts.openSans(
                                height: 1, fontWeight: FontWeight.bold,color: const Color.fromRGBO(190, 190, 190, 1))),
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
                              color: const Color.fromRGBO(192, 192, 192, 1),
                              fontSize: 16,
                              height: 3.5,
                            )),
                        TextSpan(
                            text: _courseList[index].year,
                            style: GoogleFonts.openSans(fontWeight: FontWeight.bold,color: const Color.fromRGBO(190, 190, 190, 1))),
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
                          color: const Color.fromRGBO(192, 192, 192, 1), fontSize: 16, height: 3.5)),
                  TextSpan(
                      text: _courseList[index].department.name,
                      style: GoogleFonts.openSans(
                          height: 1,fontWeight: FontWeight.bold, color: const Color.fromRGBO(190, 190, 190, 1)))
                ]))
          ],
        ),
      ),
    );
  }
}
