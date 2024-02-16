class Course {
  final String year;
  final String department;
  final String courseName;
  final String courseCode;

  Course ({
    required this.department,
    required this.year,
    required this.courseCode,
    required this.courseName}) {
    throw UnimplementedError();
  }

  factory Course.fromJson(Map<String, dynamic> json) => Course(
      year: json['year'],
      courseName: json['courseName'],
      courseCode: json['courseCode'],
      department: json['department'],
    );

}