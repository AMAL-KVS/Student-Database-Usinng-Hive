import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:core';

import 'package:student_data_base/model/db_model.dart';

class EditStudent extends StatefulWidget {
  final box = Hive.box<StudentModel>('student');
  final List<StudentModel> obj;
  final int index;
  // final formKey = GlobalKey<FormState>();

  EditStudent({Key? key, required this.obj, required this.index})
      : super(key: key);

  @override
  _EditStudentState createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();

  int? newKey;
  int? accessKey;
  XFile? image;
  String? imagePath;

  void details() {
    nameController.text = widget.obj[widget.index].name;
    ageController.text = widget.obj[widget.index].age.toString();
    placeController.text = widget.obj[widget.index].location;
    imagePath = widget.obj[widget.index].imagepath;
    qualificationController.text = widget.obj[widget.index].qualificcation;

    newKey = widget.obj[widget.index].key;
    List<StudentModel> student = widget.box.values.toList();
    for (int i = 0; i < student.length; i++) {
      if (student[i].key == newKey) {
        accessKey = i;
        break;
      }
    }
  }

  @override
  void initState() {
    details();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 34, 32, 32),
        appBar: AppBar(
          title: Text('Edit Student'),
          toolbarHeight: 90,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(48.0))),
          backgroundColor: Color.fromARGB(255, 77, 139, 136),
          elevation: 10,
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (imagePath != null)
                    ClipRRect(
                      child: Image.file(
                        File(imagePath!),
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.yellow),
                      labelText: "Name",
                      prefixIcon: Icon(
                        Icons.man,
                        color: Colors.blue,
                      ),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                    ),
                    controller: nameController,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.yellow),
                      labelText: "Age",
                      prefixIcon: Icon(
                        Icons.date_range,
                        color: Colors.blue,
                      ),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: placeController,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.yellow),
                      labelText: "Location",
                      prefixIcon: Icon(
                        Icons.location_city,
                        color: Colors.blue,
                      ),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: qualificationController,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255)),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.yellow),
                      labelText: "Qualification",
                      prefixIcon: Icon(
                        Icons.turned_in_not_outlined,
                        color: Colors.blue,
                      ),
                      border: myinputborder(),
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () =>
                              getImage(source: ImageSource.gallery),
                          child: const Text('Select New Image')),
                      ElevatedButton(
                          onPressed: () => getImage(source: ImageSource.camera),
                          child: const Text('Take New Image')),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        widget.box.putAt(
                            accessKey!,
                            StudentModel(
                                imagepath: imagePath,
                                name: nameController.text,
                                age: ageController.text,
                                location: placeController.text,
                                qualificcation: qualificationController.text));
                        Navigator.pop(context);
                      },
                      child: const Text('Submit changes'))
                ],
              ),
            ),
          ),
        ));
  }

  getImage({required ImageSource source}) async {
    image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        imagePath = (image!.path);
      });
    } else {
      return null;
    }
  }
}

OutlineInputBorder myinputborder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Color.fromARGB(255, 58, 176, 255),
        width: 3,
      ));
}

OutlineInputBorder myfocusborder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.greenAccent,
        width: 3,
      ));
}
