import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:the_course_explorer/models/courseapi.dart';

class CourseAPIService {
  final String apiurl = 'https://smsapp.bits-postman-lab.in/courses';

  Future<List<Course>> fetchCourses() async  {
    final response = await http.get(Uri.parse(apiurl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((course) => Course.fromJson(course)).toList();

    }  else {
      throw Exception('Unable to Load Courses');
    }
  }
}

class CourseRepo {
  final CourseAPIService _courseAPIService = CourseAPIService();

  Future<List<Course>> fetchCourses() {
    return _courseAPIService.fetchCourses();
  }
}