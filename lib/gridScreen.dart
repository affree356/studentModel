import 'dart:io';

import 'package:database_project/functions/db_functions.dart';
import 'package:database_project/model/datamodel.dart';
import 'package:database_project/screens/edit.dart';
import 'package:database_project/screens/profile.dart';
import 'package:flutter/material.dart';

class gridScreen extends StatelessWidget {
  const gridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(4, 158, 201, 1),
          title: const Text(
            'Student Details',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder(
            valueListenable: studentListNotifier,
            builder: (BuildContext context, List<StudentModel> studentList,
                Widget? child) {
                  if(studentList.isEmpty){
                    return const Center(
                      child: Text('No Students',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    );
                  }else{
              return GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: List.generate(studentList.length, (index) {
                  final data = studentList[index];
                  return Card(color: const Color.fromRGBO(4, 158, 201, 1),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) =>
                                profileScreen(studentModel: studentList[index])));
                      },
                      child: GridTile(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [const SizedBox(height: 20,),
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: FileImage(File(data.image)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              data.name,
                             
                            ),
                            Text(
                              data.age,
                             
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Row(
                                children: [
                                  IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) =>editScreen(studentModel: studentList[index])));
                                          // updateStudent(data);
                                        },
                                        icon: const Icon(Icons.edit)),
                              
                                IconButton(
                                  onPressed: () {
                                    deleteAlert(context, studentList[index].id!);
                                    // delStudents(data.id!);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(255, 199, 58, 58),
                                  ),
                                ),
                                  ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            }
                }
          ),
        ));

 
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
