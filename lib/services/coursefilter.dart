import 'package:flutter/material.dart';
import 'package:the_course_explorer/models/courseapi.dart';
import 'package:the_course_explorer/services/courseapi_service.dart';

class CourseFilter extends ChangeNotifier {
  List<Course> _courses = [];
  List<Course> _filteredCourses = [];
  String _searchQuery = '';
  String _selectedDepartment = 'All';
  String _selectedYear = 'All';

  List<Course> get courses => _courses;
  List<Course> get filteredCourses => _filteredCourses;
  String get searchQuery => _searchQuery;
  String get selectedDepartment => _selectedDepartment;
  String get selectedYear => _selectedYear;

  set searchQuery(String query) {
    _searchQuery = query;
    _filteredCourses = _courses
        .where((course) =>
    course.courseName.contains(_searchQuery.toUpperCase()) ||
        course.courseCode.contains(_searchQuery.toUpperCase()))
        .toList();
    notifyListeners();
  }

  set selectedDepartment(String department) {
    _selectedDepartment = department;
    _filteredCourses = _courses
        .where((course) =>
    department == 'All' || course.department == department)
        .toList();
    notifyListeners();
  }

  set selectedYear(String year) {
    _selectedYear = year;
    _filteredCourses = _courses
        .where((course) =>
    year == 'All' || course.year == year)
        .toList();
    notifyListeners();
  }

  Future<void> fetchCourses() async {
    _courses = await CourseRepo().fetchCourses();
    _filteredCourses = _courses;
    notifyListeners();
  }
}