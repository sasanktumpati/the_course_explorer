import 'dart:convert';

Courses courseFromJson(String str) => Courses.fromJson(json.decode(str));

class Courses {
  final List<CourseAPI> courses;

  Courses({
    required this.courses,
  });

  factory Courses.fromJson(Map<String, dynamic> json) => Courses(
    courses: List<CourseAPI>.from(
        json["courses"].map((x) => CourseAPI.fromJson(x))),
  );
}

class CourseAPI {
  final Department department;
  final String year;
  final String courseCode;
  final String courseName;

  CourseAPI({
    required this.department,
    required this.year,
    required this.courseCode,
    required this.courseName,
  });

  factory CourseAPI.fromJson(Map<String, dynamic> json) => CourseAPI(
      department: departmentValues.map[json["department"]]!,
      year: json["year"],
      courseCode: json["courseCode"],
      courseName: json["courseName"]);
}

enum Department { ComputerScience, Electrical, Mechanical }

final departmentValues = EnumValues({
  "Elec.": Department.Electrical,
  "Mech.": Department.Mechanical,
  "CS": Department.ComputerScience
});


























































class EnumValues<T> {
  Map<String, T> map;
  EnumValues(this.map);
}
