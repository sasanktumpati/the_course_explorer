import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_course_explorer/Screens/home_listview.dart';
import 'package:the_course_explorer/services/courseapi_service.dart';
import 'package:the_course_explorer/models/courseapi.dart';

import 'widgets/dropdown_menu.dart';
import 'widgets/search_field.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final course = ref.watch(courseRepo).when(
      data: (value) => value,
      loading: () => null,
      error: (error, stack) => error.toString(),
    );
    List<String> yearList = ['1st', '2nd', '3rd', '4th'];
    List<String> departmentList = Department.values.map((e) => e.name).toList();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff001F3F),
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage("assets/background_image.png"),
          ),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.00003,
          left: MediaQuery.of(context).size.width * 0.00003,
          top: 50,
        ),
        child: Column(
          children: [
            const SearchBox(),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  DropDownMenu(
                    list: departmentList,
                    hintText: "Select Department",
                    choiceProvider: depList,
                  ),
                  DropDownMenu(
                    list: yearList,
                    hintText: "Select Year",
                    choiceProvider: yearList,
                  )
                ],
              ),
            ),
            if (course == null)
              const CircularProgressIndicator()
            else if (course is List<Courses>)
              const CourseViewHome()
            else
              const Text('Connection Lost'),
          ],
        ),
      ),
    );
  }
}
