import 'package:the_course_explorer/models/courseapi.dart';
import 'package:the_course_explorer/services/courseapi_service.dart';

class CourseRepo {
  final CourseAPIService _courseAPIService = CourseAPIService();

  Future<List<Course>> fetchCourses() {
    return _courseAPIService.fetchCourses();
  }
}
