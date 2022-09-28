import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_data_base/model/db_model.dart';

class StudentView extends StatelessWidget {
  final box = Hive.box<StudentModel>('student');
  final List<StudentModel> obj;
  final int index;
  StudentView({Key? key, required this.obj, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(179, 39, 37, 37),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 77, 139, 136),
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(48.0))),
        title: Text('Student Details'),
        centerTitle: true,
        elevation: 10,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 100,
                  backgroundColor: Color.fromARGB(255, 233, 235, 233),
                  child: obj[index].imagepath == null
                      ? null
                      : ClipOval(
                          child: Image.file(
                            File(obj[index].imagepath),
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                        )),
              const SizedBox(height: 10),
              Text(
                'Name : ${obj[index].name}',
                style: const TextStyle(
                    color: Color.fromARGB(255, 17, 191, 221), fontSize: 35),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Place : ${obj[index].location}',
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                ('Age : ${obj[index].age}'),
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                ('Qualification : ${obj[index].qualificcation}'),
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
