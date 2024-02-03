import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../../components/components.dart';

// ignore: must_be_immutable

class NewTasksScreen extends StatefulWidget {
  NewTasksScreen({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  List<Map> tasks;

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, Appstates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = Appcubit.get(context).newtasks;
          return ConditionalBuilder(
            condition: tasks.isNotEmpty,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) =>
                    buildtaskitem(tasks[index], context),
                separatorBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.cyanAccent,
                    ),
                itemCount: tasks.length),
            fallback: (context) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image:
                            AssetImage('assets/images/empty new tasks2.png'))),
                child: const Padding(
                  padding: EdgeInsets.only(top: 370.0),
                  child: Center(
                      child: Text(
                    'No tasks yet, Add New task',
                    style: TextStyle(fontSize: 20,color: Colors.blue),
                  )),
                ),
              ),
            ),
          );
        });
  }
}
