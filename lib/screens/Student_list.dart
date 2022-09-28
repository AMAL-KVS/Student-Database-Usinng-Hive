import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:student_data_base/screens/Student_view.dart';
import '../model/db_model.dart';

import 'dart:core';

class ListStudent extends StatefulWidget {
  const ListStudent({Key? key}) : super(key: key);

  @override
  State<ListStudent> createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<StudentModel>('student').listenable(),
        builder:
            (BuildContext ctx, Box<StudentModel> studentList, Widget? child) {
          List keys = studentList.keys.toList();
          // final data = box.get("favorites");
          // var searchInput;
          var searchInput;
          List<StudentModel> data = studentList.values
              .toList()
              .where((element) => element.name
                  .toLowerCase()
                  .contains(searchInput.toLowerCase()))
              .toList();
          return ListView.separated(
            itemBuilder: (ctx, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 209, 14, 14),
                  radius: 50,
                ),
                textColor: Color.fromARGB(255, 235, 232, 211),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StudentView(
                            obj: data,
                            index: index,
                          )));
                },
                title: Text(data[index].name),
                subtitle: Text(data[index].age),
                tileColor: Color.fromARGB(92, 34, 34, 32),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                      color: Color.fromARGB(255, 172, 131, 20)),
                  IconButton(
                    onPressed: () {
                      // if (data[index].id != null) {
                      //   deleteStudent(data[index].id!);
                      // }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Are you sure? '),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No')),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        data[index].delete();
                                        // deleteStudent(data[index]);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Yes')),
                              ],
                            );
                          });
                    },
                    icon: Icon(Icons.delete),
                    color: Color.fromARGB(255, 192, 34, 34),
                  ),
                ]),
              );
            },
            separatorBuilder: (ctx, index) {
              return const Divider();
            },
            itemCount: studentList.length,
          );
        });
  }
}
