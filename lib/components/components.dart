import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';


Widget buildtaskitem(Map model, context) => Padding(
  padding: const EdgeInsets.only(top: 15.0,bottom: 15.0,left: 5),
  child: Row(
    children: [
      CircleAvatar(
        radius: 35,
        child: Text('${model['time']}'),
      ),
      const SizedBox(
        width: 5,
      ),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${model['title']}',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              '${model['date']}',
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            )
          ],
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      IconButton(
          onPressed: () {
            Appcubit.get(context).updatedata(
              status: 'done',
              id: model['id'],
            );
          },
          icon: const Icon(
            Icons.done_all_outlined,
            color: Colors.green,
          )),
      IconButton(
          onPressed: () {
            Appcubit.get(context).updatedata(
              status: 'archive',
              id: model['id'],
            );
          },
          icon: const Icon(
            Icons.archive,
            color: Colors.black38,
          )),
      IconButton(
          onPressed: () {
            Appcubit.get(context).deletedata(
              id: model['id'],
            );
          },
          icon: const Icon(
            Icons.delete_forever,
            color: Colors.redAccent,
          )),

    ],
  ),
);
