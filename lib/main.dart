import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'coursefilter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CourseFilter(),
      child: MaterialApp(
        title: 'Course App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _CourseFilter = CourseFilter();

  @override
  void initState() {
    super.initState();
    _CourseFilter.fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CourseSearchDelegate(_CourseFilter),
              );
            },
          ),
        ],
      ),
      body: Consumer<CourseFilter>(
        builder: (context, CourseFilter, child) {
          if (CourseFilter.courses.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: CourseFilter.filteredCourses.length,
              itemBuilder: (context, index) {
                final course = CourseFilter.filteredCourses[index];
                return ListTile(
                  leading: Text(course.courseCode),
                  title: Text(course.courseName),
                  subtitle: Text('${course.year} - ${course.department}'),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton<String>(
              value: CourseFilter.selectedDepartment,
              onChanged: (value) {
                CourseFilter.selectedDepartment = value!;
              },
              items: [
                DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
                ...CourseFilter.courses
                    .map((course) => DropdownMenuItem(
                  value: course.department,
                  child: Text(course.department),
                ))
                    .toList(),
              ],
            ),
            DropdownButton<String>(
              value: CourseFilter.selectedYear,
              onChanged: (value) {
                CourseFilter.selectedYear = value!;
              },
              items: [
                DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
                ...CourseFilter.courses
                    .map((course) => DropdownMenuItem(
                  value: course.year,
                  child: Text(course.year),
                ))
                    .toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CourseSearchDelegate extends SearchDelegate {
  final CourseFilter _CourseFilter;

  CourseSearchDelegate(this._CourseFilter);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _CourseFilter.courses
        .where((course) => course.courseName
        .contains(query.toUpperCase()) ||
        course.courseCode.contains(query.toUpperCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final course = results[index];
        return ListTile(
          leading: Text(course.courseCode),
          title: Text(course.courseName),
          subtitle: Text('${course.year} - ${course.department}'),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = _CourseFilter.courses
        .where((course) => course.courseName
        .contains(query.toUpperCase()) ||
        course.courseCode.contains(query.toUpperCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final course = suggestions[index];
        return ListTile(
          leading: Text(course.courseCode),
          title: Text(course.courseName),
          subtitle: Text('${course.year} - ${course.department}'),
        );
      },
    );
  }
}