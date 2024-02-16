import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:the_course_explorer/models/course.dart';

class CourseAPIService {
  final String url = 'https://smsapp.bits-postman-lab.in/courses';

  Future<List<Course>> getCourse() async  {
    final response = await http.get(url as Uri);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((course) => Course.fromJson(course)).toList();

    }  else {
      throw Exception('Failed to Load Courses');
    }

  }
}