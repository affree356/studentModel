import 'package:flutter/material.dart';

class StudentModel{
 
   int? id;
   final String name;
  final  String age;
  final String mark;
   final String place;
  final  String num;
   final String image;

  StudentModel({required this.name,required this.age,required this.mark, required this.place,required this.num,required this.image ,this.id});


static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int?;
    final name = map['name'] as String? ?? '';
    final age = map['age'] as String? ?? '';
    final mark =map['mark'] as String? ?? '';
    final place = map['place'] as String? ?? '';
    final num = map['num'] as String? ?? '';
    final image = map['image'] as String? ?? '';

    return StudentModel(id: id, name: name, age: age,mark: mark, place: place, num: num, image: image);
  }
}