import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_data_base/model/db_model.dart';
import 'package:student_data_base/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // if (Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
  Hive.registerAdapter(StudentModelAdapter());
  //}
  await Hive.openBox<StudentModel>('student');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(primaryColor: Color.fromARGB(255, 255, 255, 255)),
      home: const HomePage(),
    );
  }
}
