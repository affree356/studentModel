import 'dart:developer';
import 'dart:io';
import 'package:database_project/functions/db_functions.dart';
import 'package:database_project/model/datamodel.dart';
import 'package:database_project/screens/edit.dart';
import 'package:database_project/screens/profile.dart';
import 'package:flutter/material.dart';

class listScreen extends StatelessWidget {
  const listScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (BuildContext context, List<StudentModel> studentList,
              Widget? child) {
            if (studentList.isEmpty) {
              return Center(
                child: Text(
                  'No Students',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: studentList.length,
                  itemBuilder: (context, index) {
                    final data = studentList[index];
                    log(data.toString());
                   
                    return Card(
                        color:  Color.fromRGBO(4, 158, 201, 1),
                        child: ListTile(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (ctx) => profileScreen(
                                      studentModel: studentList[index]))),
                          leading: CircleAvatar(
                            backgroundImage: FileImage(File(data.image)),
                          ),
                          title: Text(
                            data.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          subtitle: Text(
                            data.age,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) => editScreen(
                                                studentModel: data)));
                                    // updateStudent(data);
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                onPressed: () {
                                  deleteAlert(
                                      context, studentList[index].id!);
                                  // delStudents(data.id!);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Color.fromARGB(255, 199, 58, 58),
                                ),
                              ),
                            ],
                          ),
                        ));
                  });
            }
          }),
    );
  }

  deleteAlert(BuildContext context, int id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Alert'),
            content: const Text('Do you want to delete'),
            actions: [
              TextButton(
                onPressed: () {
                  delStudents(id);
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }
}
