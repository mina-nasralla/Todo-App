import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components/components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';




class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Appcubit, Appstates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = Appcubit.get(context).archivetasks;
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
                        fit: BoxFit.fitWidth,
                        image:
                        AssetImage('assets/images/empty archived tasks.png'))),
                child: const Padding(
                  padding: EdgeInsets.only(top: 390.0),
                  child: Center(
                      child: Text(
                        'No Archived tasks yet',
                        style: TextStyle(fontSize: 20,color: Colors.indigo),
                      )),
                ),
              ),
            ),
          );
        });
  }
}
