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
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<Courses> course = ref.watch(courseRepo.future);
    List<String> yearList = ['1st', '2nd', '3rd', '4th'];
    List<String> departmentList = Department.values.map((e) => e.name).toList();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xff001F3F),
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage("assets/background.png"),
          ),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.01,
          left: MediaQuery.of(context).size.width * 0.01,
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
                    choiceProvider: yearListProv,
                  )
                ],
              ),
            ),
            FutureBuilder<Courses>(
              future: course,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CourseViewHome(data: [snapshot.data!]);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
