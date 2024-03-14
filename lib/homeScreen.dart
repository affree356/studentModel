// import 'package:database_project/formScreen.dart';
import 'package:database_project/addStudent.dart';
import 'package:database_project/functions/db_functions.dart';
import 'package:database_project/gridScreen.dart';
import 'package:database_project/listscreen.dart';
import 'package:database_project/model/datamodel.dart';
import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  final searchController = TextEditingController();

  

  @override
  void initState() {
    getAllStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (BuildContext context, List<StudentModel> studentList, Widget?child){
        return  DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Student details',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                 
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => const gridScreen()));
                    },
                    icon: const Icon(
                      Icons.grid_view,
                    ),
                  )
                ],
                backgroundColor: const Color.fromRGBO(4, 158, 201, 1),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(onChanged: (value) {
                      searchPerson(value);
                    },
                       
                       controller:searchController ,
                    
                    
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                          prefixIcon: const Icon(Icons.search),
                         
                          hintText: 'Search..',
                          
                          ),
                        
                    ),
                  ),
                  const Expanded(child: listScreen())
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => formScreen()));
                },
                child: const Icon(Icons.add),
              )));
      },
      
    );
  }
}



 
