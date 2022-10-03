import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/functions/alert_dialog.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/services/task_service.dart';

class BuildTasks extends StatelessWidget {
  final List<Task>? tasks;
  final dynamic listAllState;
  static final dateFormat = DateFormat('dd/MM/yyyy - hh:mm');

  const BuildTasks({super.key, this.tasks, this.listAllState});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: tasks?.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 10,
          margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: ListTile(
            visualDensity: const VisualDensity(vertical: 1), // to expand

            title: Text(tasks![index].description),
            subtitle: Text(
                dateFormat.format(DateTime.parse(tasks![index].createdAt))),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: tasks![index].done,
                  onChanged: (value){
                    Task task = tasks![index];
                    task.done = !task.done;
                    TaskService().updateTaskStatus(task.id, task).then((updated){
                      listAllState.refreshData();
                    });
                  },
                ),
                IconButton(
                    onPressed: () {
                      TaskService().deleteTask(tasks![index].id).then(
                        (deleted) {
                          if (deleted == true) {
                            Dialogue(
                              context: context,
                              icon: const Icon(Icons.done),
                              title: 'Sucesso',
                            ).show('Tarefa excluída com sucesso');
                            listAllState.refreshData();
                          }
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
