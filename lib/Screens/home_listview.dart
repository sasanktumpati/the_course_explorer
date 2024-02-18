import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../coursecard.dart';
import '../models/courseapi.dart';
import '../services/courseapi_service.dart';

class CourseViewHome extends ConsumerWidget {
  const CourseViewHome({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courses = ref.watch(courseRepo);
    return courses.when(
        data: (data) {
          return ScrollableListView(data: data);
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}

class ScrollableListView extends ConsumerStatefulWidget {
  const ScrollableListView({
    super.key,
    required this.data,
  });

  final Courses data;

  @override
  ConsumerState<ScrollableListView> createState() => _ScrollableListViewState();
}

class _ScrollableListViewState extends ConsumerState<ScrollableListView> {
  @override
  Widget build(BuildContext context) {
    final textInput = ref.watch(searchQuery);
    final List<CourseAPI> courses;
    final selectedDepartment = ref.watch(depList);
    final selectedYear = ref.watch(yearList);

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
          return filteredlist(
            courseList: courses,
            index: index,
          );
        },
      ),
    );
  }
}
