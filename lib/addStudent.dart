import 'dart:io';

import 'package:database_project/functions/db_functions.dart';
import 'package:database_project/homeScreen.dart';
import 'package:database_project/listscreen.dart';
import 'package:database_project/model/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class formScreen extends StatefulWidget {
  formScreen({super.key});

  @override
  State<formScreen> createState() => _formScreenState();
}

class _formScreenState extends State<formScreen> {
  final nameController = TextEditingController();

  final ageController = TextEditingController();

  final placeController = TextEditingController();

  final numController = TextEditingController();
  final markController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String? selectedimage;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter the details',style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: const Color.fromRGBO(4, 158, 201, 1),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  selectedimage==null ?GestureDetector(
                    onTap: () {
                      pickImage();
                    },child:const Icon(Icons.add_a_photo,size: 50,),
                  
                  ) 
                  :SizedBox(height:200,  child: Image.file(File(selectedimage!)),),
                const SizedBox(height: 20,),
                  Container(
                    color: const Color.fromARGB(255, 213, 143, 72),
                    child: TextButton(onPressed: (){
                      pickImage();
                    }, child:const Text('pick image frome gallery',
                    style: TextStyle(color: Colors.black),)),
                  ),
                  
                
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label:Text('Name'),
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
                    keyboardType: TextInputType.number,
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'mark'
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: placeController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Place'),
                         hintText: ' Enter your place'),
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
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      
                        border: OutlineInputBorder(),
                        label: Text('Contact'),
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
                  
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                         
                          saveData(context);
                         
                        }
                      },
                      child:const Text('submit'),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveData(BuildContext ctx) async{
    final name = nameController.text;
    final age = ageController.text;
    final place = placeController.text;
    final num = numController.text;
    final mark = markController.text;
    final image = selectedimage;

    if (name.isEmpty || age.isEmpty ||mark.isEmpty|| place.isEmpty || num.isEmpty||image!.isEmpty) {
      return;
    }else{
    ScaffoldMessenger.of(ctx).showSnackBar(
       const SnackBar(content: Text('Successfully submitted'),
       behavior: SnackBarBehavior.floating,
       backgroundColor: Colors.green,
       margin: EdgeInsets.all(10),
       duration: Duration(seconds: 5),
       ));
       
    final student = StudentModel(name: name, age: age,mark: mark, place: place, num: num,image: selectedimage! );
    await addAllStudent(student);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
  builder: (context)=> const homeScreen()));
    }
  }

  Future pickImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (returnedImage != null) {
        selectedimage = returnedImage.path;
      }
    });
  }
 
}
