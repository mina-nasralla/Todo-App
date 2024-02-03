// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/modules/archive_tasks/archived_tasks_screen.dart';
import 'package:todo_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:todo_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:todo_app/shared/cubit/states.dart';

class Appcubit extends Cubit<Appstates> {
  Appcubit() : super(AppInitialStates());

  static Appcubit get(context) => BlocProvider.of(context);
  int currentindex = 0;
  List<Widget> screens = [
    NewTasksScreen(
      tasks: const [],
    ),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeindex(int index) {
    currentindex = index;
    emit(AppchangebottomNavbar());
  }

  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print('data created');
      database
          .execute(
              'create table tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('error on creating ${error.toString()}');
      });
    }, onOpen: (database) {
      getfromdatabase(database);
      print('data opened');
    }).then((value) {
      database = value;
      emit(Appcreatdatabase());
    });
  }

  late Database database;

  insertintodatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database.transaction((txn) => txn
            .rawInsert(
                'insert into tasks (title, date, time, status) values("$title","$date","$time","new")')
            .then((value) {
          print('row added successfully');
          emit(Appinsertdatabase());
          getfromdatabase(database);
        }).catchError((error) {
          print('error on record ${error.toString()}');
        }));
  }

  void getfromdatabase(database) {
    newtasks = [];
    donetasks = [];
    archivetasks = [];

    emit(Appgetdatabase());
    database.rawQuery('select * from tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newtasks.add(element);
        } else if (element['status'] == 'done') {
          donetasks.add(element);
        } else {
          archivetasks.add(element);
        }
      });
      emit(Appgetdatabase());
    });
  }

  bool isbottomsheetshown = false;
  IconData buttonicon = Icons.add_card_sharp;

  void changiconbutton({
    required bool isShow,
    required IconData icon,
  }) {
    isbottomsheetshown = isShow;
    buttonicon = icon;
    emit(Appchangefloatingbottom());
  }

  void updatedata({
    required String status,
    required int id,
  }) async {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      getfromdatabase(database);
      emit(Appupdatedatabase());
    });
  }

  void deletedata({
    required int id,
  }) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getfromdatabase(database);
      emit(Appdeletedatabase());
    });
  }
}
