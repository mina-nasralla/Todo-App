// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class Homelayout extends StatelessWidget {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();
  late String value;

  Homelayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Appcubit()..createDatabase(),
      child: BlocConsumer<Appcubit, Appstates>(
        listener: (BuildContext context, Appstates state) {
          if (state is Appinsertdatabase) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, Appstates state) {
          Appcubit cubit = Appcubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(title: Text(cubit.titles[cubit.currentindex])),
            body: cubit.screens[cubit.currentindex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isbottomsheetshown) {
                  if (formkey.currentState!.validate()) {
                    cubit.insertintodatabase(
                        title: titlecontroller.text,
                        date: datecontroller.text,
                        time: timecontroller.text);
                    // cubit
                    //     .insertintodatabase(
                    //   title: titlecontroller.text,
                    //   date: datecontroller.text,
                    //   time: timecontroller.text,
                    // )
                    //     .then((value) {
                    //   cubit.getfromdatabase(cubit.database).then((value) {
                    //     Navigator.pop(context);
                    //   });
                    // });
                  }
                } else {
                  scaffoldkey.currentState
                      ?.showBottomSheet(
                        (context) => Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Form(
                              key: formkey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.blueAccent)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'title must not be Empty';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.text,
                                        controller: titlecontroller,
                                        decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.task),
                                            hintText: 'The Task '),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.blueAccent)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'time must not be Empty';
                                          }
                                          return null;
                                        },
                                        onTap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) {
                                            timecontroller.text =
                                                value!.format(context);
                                            print(value.format(context));
                                          });
                                        },
                                        controller: timecontroller,
                                        decoration: const InputDecoration(
                                            prefixIcon:
                                                Icon(Icons.timer_outlined),
                                            hintText: 'Task time'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.blueAccent)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'date must not be Empty';
                                          }
                                          return null;
                                        },
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.parse(
                                                      '4000-08-21'))
                                              .then((value) {
                                            datecontroller.text =
                                                DateFormat.yMMMd()
                                                    .format(value!);
                                          });
                                        },
                                        controller: datecontroller,
                                        decoration: const InputDecoration(
                                            prefixIcon:
                                                Icon(Icons.calendar_month),
                                            hintText: 'Task date'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        elevation: 50,
                      )
                      .closed
                      .then((value) {
                    cubit.changiconbutton(
                        isShow: false, icon: Icons.add_card_sharp);
                    // });
                  });

                  cubit.changiconbutton(
                      isShow: true, icon: Icons.add_task_outlined);
                }
              },
              child: Icon(cubit.buttonicon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: Appcubit.get(context).currentindex,
              onTap: (index) {
                cubit.changeindex(index);
              },
              type: BottomNavigationBarType.fixed,
              elevation: 30,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done_outline_outlined),
                  label: 'done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archive',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
