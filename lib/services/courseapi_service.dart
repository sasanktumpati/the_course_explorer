import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/courseapi.dart';

Future<Courses> fetchCourse() async {
  final response =
  await http.get(Uri.parse('https://smsapp.bits-postman-lab.in/courses'));

  if (response.statusCode == 200) {
    return Courses.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception(
        'Unable to Load Data. Check Your Connection and Try Again.');
  }
}

final courseRepo = FutureProvider<Courses>((ref) {
  return http.get(Uri.parse('https://smsapp.bits-postman-lab.in/courses'))
      .then((response) {
    if (response.statusCode == 200) {
      return Courses.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Unable to Load Data. Check Your Connection and Try Again.');
    }
  })
      .catchError((error) {
    throw Exception('Failed to fetch data: $error');
  });
});


final searchQuery = StateProvider<String>((ref) => '');

final depList = StateProvider<String>((ref) => '');

final yearListProv = StateProvider<String>((ref) => '');
