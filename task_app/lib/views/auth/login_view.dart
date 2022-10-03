import 'package:flutter/material.dart';
import 'package:task_app/views/auth/login_form.dart';
import 'package:task_app/views/task/task_list.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'images/taskpad.png',
              height: 256,
            ),
            const LoginForm(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
          child: Padding(padding: EdgeInsets.all(16), child: Text('PROJETO MOBILE UFRPE - 2021.2'))),
    );
  }
}
