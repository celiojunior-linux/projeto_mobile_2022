import 'package:flutter/material.dart';
import 'package:task_app/functions/alert_dialog.dart';
import 'package:task_app/services/task_service.dart';


class TaskForm extends StatefulWidget {
  final dynamic state;
  const TaskForm({Key? key, required this.state }) : super(key: key);

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();

  void _create(context) {
    ValidationDialogue dialoguer = ValidationDialogue(context: context);
    if (_descriptionController.text.replaceAll(' ', '') == '') {
      dialoguer.show('Descrição inválida');
      return;
    }
    TaskService().createTask(_descriptionController.text).then((created) {
      if (created == true) {
        Dialogue(
          context: context,
          icon: const Icon(Icons.done),
          title: 'Sucesso',
        ).show('Tarefa criada com sucesso!');
        _descriptionController.text = '';
        widget.state.refreshData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Descrição'),
            ),
            controller: _descriptionController,
            keyboardType: TextInputType.text,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
          ),
          ElevatedButton(
            onPressed: () => {_create(context)},
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60)),
            child: const Text(
              'Cadastrar',
            ),
          ),
        ],
      ),
    );
  }
}
