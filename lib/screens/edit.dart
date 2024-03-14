import 'dart:io';

import 'package:database_project/functions/db_functions.dart';
import 'package:database_project/homeScreen.dart';
import 'package:database_project/listscreen.dart';
import 'package:database_project/model/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class editScreen extends StatefulWidget {
  StudentModel studentModel;
 

  editScreen({super.key,required this.studentModel});

  @override
  State<editScreen> createState() => _editScreenState();
}

class _editScreenState extends State<editScreen> {
  var nameController= TextEditingController();

  var ageController = TextEditingController();
  var placeController = TextEditingController();
  var numController = TextEditingController();
  var imageController = TextEditingController();
  var markController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? selectedimage;
  final picker =ImagePicker();

  @override

  void initState() {
    setState(() {
      nameController= TextEditingController(text: widget.studentModel.name);
      ageController = TextEditingController(text: widget.studentModel.age);
      placeController = TextEditingController(text: widget.studentModel.place);
      numController=TextEditingController(text: widget.studentModel.num);
      markController = TextEditingController(text: widget.studentModel.mark);
      selectedimage =widget.studentModel.image;
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    int id =widget.studentModel.id!;
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromRGBO(4, 158, 201, 1),
        title: const Text('Enter the Details'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                      
                      children: [
                        Center(
                          child: Text(
                            'Update Student',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 55, 119, 57),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ), 
                        selectedimage==null ?const Text('select a image') 
                      :Container(height:200,  child: Image.file(File(selectedimage!)),),
                    const SizedBox(height: 20,),
                        Container(color: const Color.fromARGB(255, 134, 111, 44),
                          child: TextButton(onPressed: (){
                               pickImage();
                          }, child: Text('pick image from gallery',style: TextStyle(color: Colors.black),)),
                        ),SizedBox(height: 20,),
                        
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Name'),
                              hintText: 'Enter your name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'name is required';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: ageController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('Age'),
                              hintText: 'Enter your age'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'age is required';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: markController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Mark'
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: placeController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('place'),
                              hintText: 'Enter your place'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'place is required';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: numController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text('contact'),
                              hintText: 'Enter your phone number'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'phone number is required';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 38, 97, 39)),
                            onPressed: () {
                              if(formKey.currentState!.validate()){
                                   updateData(context, id);
                              }  
                            },
                            child: const Text(
                              'update',
                              style: TextStyle(color: Colors.white),
                            ))
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateData(BuildContext context,int id) async {
    
    final name = nameController.text;
    final age = ageController.text;
    final place = placeController.text;
    final num = numController.text;
    final mark =markController.text;
    

    if(name.isEmpty||age.isEmpty||mark.isEmpty|| place.isEmpty||num.isEmpty){
      return;
    }else{

      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Successfully updated'),
       behavior: SnackBarBehavior.floating,
       backgroundColor: Colors.green,
       margin: EdgeInsets.all(10),
       duration: Duration(seconds: 5),
       ));
     final student = StudentModel(id:id, name: name, age: age,mark:mark , place: place, num: num, image: selectedimage! );
      updateStudent(student);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>homeScreen()));
    }
  }

  Future pickImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
        if(returnedImage!=null){

        }

    setState(() {
      if (returnedImage != null) {
        selectedimage = returnedImage.path;
      }
    });
  }
}
