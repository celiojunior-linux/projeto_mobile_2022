import 'package:flutter/material.dart';
import 'package:task_app/views/task/task_form.dart';

class TaskCreateView extends StatefulWidget {
  final dynamic state;

  const TaskCreateView({Key? key, required this.state}) : super(key: key);

  @override
  State<TaskCreateView> createState() => _TaskCreateViewState();
}

class _TaskCreateViewState extends State<TaskCreateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Tarefa')),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'images/taskpad_2.png',
                width: 128,
              ),
            ),
            TaskForm(state: widget.state),
          ],
        ),
      ),
    );
  }
}
