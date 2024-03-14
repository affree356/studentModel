import 'dart:developer';

import 'package:database_project/model/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

late Database _db;
Future<void> initializeDatabase() async {
  _db = await openDatabase('student.db', version: 2,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE student (id INTEGER PRIMARY KEY,name TEXT,age TEXT,place TEXT,num TEXT,image TEXT,mark TEXT)');
  },
    onUpgrade:  (Database db, int oldVersion, int newVersion){
    
     if(oldVersion>2){
        _db.execute('ALTER TABLE student ADD COLUMN mark TEXT');

     }
  } );
  
  
}

Future<void> addAllStudent(StudentModel value) async {
  log(value.name);
  await _db.rawInsert(
      'INSERT INTO student(name,age,place,num,image) VALUES (?,?,?,?,?)',
      [value.name, value.age, value.place, value.num, value.image]);
  getAllStudents();
}

Future<void> getAllStudents() async {
  studentListNotifier.value.clear();
  final values = await _db.rawQuery('SELECT * FROM student');
  studentListNotifier.value =
      values.map((map) => StudentModel.fromMap(map)).toList();

  studentListNotifier.notifyListeners();
}

void searchPerson(String enteredkeyword) async {
  studentListNotifier.value.clear();
  final value = await _db.rawQuery('SELECT * FROM student');
  value.forEach((value) {
    final data = StudentModel.fromMap(value);
    if (data.name.contains(enteredkeyword)) {
      studentListNotifier.value.add(data);
      studentListNotifier.notifyListeners();
    }
  });
}

Future<void> updateStudent(StudentModel value) async {
  await _db.rawUpdate(
      'UPDATE student SET  name=?,age =?,place=?,num=?, image =? WHERE id=?',
      [value.name, value.age, value.place, value.num, value.image, value.id]);
  getAllStudents();
  studentListNotifier.notifyListeners();
}

Future<void> delStudents(int id) async {
  await _db.rawDelete('DELETE FROM student WHERE id =?', [id]);
  getAllStudents();
  studentListNotifier.notifyListeners();
}
