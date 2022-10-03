import 'package:flutter/material.dart';
import 'package:task_app/views/task/task_create.dart';
import 'package:task_app/views/task/task_list.dart';

import '../store/ducks/auth.dart';
import '../views/auth/login_view.dart';

class DrawerBuilder {
  static void showAlertDialog(BuildContext context) {
    TextButton cancelButton = TextButton(
      child: const Text("Cancelar"),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    TextButton continueButton = TextButton(
      child: const Text("Sim"),
      onPressed: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
            (route) => false);
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Atenção"),
      content: const Text("Deseja deslogar?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Drawer build(BuildContext context, var viewState) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Column(
                  children: [
                    Image.asset('images/taskpad.png'),
                    Text('Bem-vindo, ${AuthDucks().currentUser?.username}!')
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskCreateView(state: viewState),
                    ),
                  ),
                },
                child: const Text('Nova Tarefa'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (
                          context,
                          animation1,
                          animation2,
                        ) =>
                            const TaskListView(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero),
                  )
                },
                child: const Text('Tarefas'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () => {showAlertDialog(context)},
                child: const Text('Sair'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
