import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/courseapi.dart';
import '../services/courseapi_service.dart';
import '../widgets/coursecard.dart';

class CourseViewHome extends ConsumerWidget {
  const CourseViewHome({super.key, required this.data});

  final List<Courses> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(courseRepo);
    return courses.when(
        data: (data) {
          return ScrollableList(data: data);
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}

class ScrollableList extends ConsumerStatefulWidget {
  const ScrollableList({
    super.key,
    required this.data,
  });

  final Courses data;

  @override
  ConsumerState<ScrollableList> createState() => _ScrollableListState();
}

class _ScrollableListState extends ConsumerState<ScrollableList> {
  @override
  Widget build(BuildContext context) {
    final ref = this.ref;

    final textInput = ref.watch(searchQuery);
    final List<CourseAPI> courses;
    final selectedDepartment = ref.watch(depList);
    final selectedYear = ref.watch(yearListProv);

    courses = widget.data.courses.where((element) {
      if (selectedYear.isNotEmpty && element.year != selectedYear) {
        return false;
      }
      if (selectedDepartment.isNotEmpty &&
          element.department.name != selectedDepartment) {
        return false;
      }
      if (textInput.isNotEmpty &&
          !(element.courseName.toLowerCase().contains(textInput) ||
              element.courseCode.toLowerCase().contains(textInput))) {
        return false;
      }
      return true;
    }).toList();

    return Expanded(
      child: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return FilteredList(
            courseList: courses,
            index: index,
          );
        },
      ),
    );
  }
}