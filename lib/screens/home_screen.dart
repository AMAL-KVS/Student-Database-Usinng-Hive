import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:core';

import 'package:student_data_base/model/db_model.dart';
import 'package:student_data_base/screens/Student_view.dart';
import 'package:student_data_base/screens/edit.dart';

import 'add_students.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Icon myIcon = const Icon(Icons.search);
  Widget myField = const Text('Student Data');
  String searchInput = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(202, 27, 26, 26),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 77, 139, 136),
        toolbarHeight: 200,
        shadowColor: Color.fromARGB(255, 16, 117, 201),
        title: myField,
        centerTitle: true,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(48.0))),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (myIcon.icon == Icons.search) {
                    myIcon = const Icon(Icons.clear);
                    myField = TextField(
                      onChanged: (value) {
                        searchInput = value;
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 151, 142, 142))),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255))),
                        hintText: 'Search here',
                      ),
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    );
                  } else {
                    setState(() {
                      searchInput = '';
                    });
                    myIcon = const Icon(Icons.search);
                    myField = const Text(
                      'Students list',
                    );
                  }
                });
              },
              icon: myIcon),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<StudentModel>('student').listenable(),
        builder: (context, Box<StudentModel> value, child) {
          List keys = value.keys.toList();
          if (keys.isEmpty) {
            return const Center(
              child: Text('List is empty'),
            );
          } else {
            List<StudentModel> data = value.values
                .toList()
                .where((element) => element.name
                    .toLowerCase()
                    .contains(searchInput.toLowerCase()))
                .toList();
            if (data.isEmpty) {
              return const Center(
                  child: Text(
                'Sorry, no results found ',
                style: TextStyle(color: Colors.white),
              ));
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                // Student? data = value.getAt(index);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            StudentView(obj: data, index: index))),
                    // tileColor: Colors.lightGreen[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text(data[index].name),
                    leading: data[index].imagepath == null
                        ? CircleAvatar(
                            backgroundColor: Colors.green.shade100,
                            radius: 20,
                          )
                        : CircleAvatar(
                            child: ClipOval(
                              child: Image.file(
                                File(data[index].imagepath),
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    EditStudent(obj: data, index: index)));
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
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
                                            data[index].delete();
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Yes'))
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    tileColor: Color.fromARGB(255, 202, 200, 181),
                  ),
                );
              },

              itemCount: data.length,
              // separatorBuilder: Divider(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddStudent()));
        },
      ),
    );
  }
}
