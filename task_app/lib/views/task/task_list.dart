import 'package:flutter/material.dart';
import 'package:task_app/components/drawer.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/services/task_service.dart';
import 'package:task_app/views/task/build_tasks.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({Key? key}) : super(key: key);

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  late Future<List<Task>> tasks;

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  Future<List<Task>> refreshData() {
    setState(() {
      tasks = TaskService().getTasks();
    });
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tarefas'), actions: []),
      drawer: DrawerBuilder.build(context, this),
      body: RefreshIndicator(
        onRefresh: () => refreshData(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 100),
          child: FutureBuilder<List<Task>>(
              future: tasks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Column(
                      children: [
                        Text('Snapshot Error: ${snapshot.error}'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(200, 50)),
                            onPressed: () => refreshData(),
                            child: const Text('Atualizar'),
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.data.toString() == '[]') {
                    return const Center(
                        child: Text('Ainda não há tarefas cadastradas'));
                  } else {
                    return BuildTasks(
                      tasks: snapshot.data,
                      listAllState: this,
                    );
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              }),
        ),
      ),
    );
  }
}
