import 'package:flutter/material.dart';
import 'package:task_app/views/user/sign_form.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Usuário')),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'images/signup.png',
                width: 128,
              ),
            ),
            const SignupForm(),
          ],
        ),
      ),
    );
  }
}
