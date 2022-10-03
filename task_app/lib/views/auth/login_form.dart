import 'package:flutter/material.dart';
import 'package:task_app/services/authenticator.dart';
import 'package:task_app/views/task/task_list.dart';
import 'package:task_app/views/user/sign_view.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    Authenticator authenticator = Authenticator();
    authenticator
        .getToken(
      _usernameController.text,
      _passwordController.text,
    )
        .then(
      (token) {
        if (!(token == null)) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const TaskListView()),
            (route) => false,
          );
        }
      },
    ).catchError((e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro de Autenticação'),
          icon: Icon(Icons.error_outline),
          content: Text(e.message),
        ),
      );
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
              label: Text('Usuário'),
              border: OutlineInputBorder(),
            ),
            controller: _usernameController,
            keyboardType: TextInputType.text,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Senha'),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
            controller: _passwordController,
            obscureText: true,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
          ),
          ElevatedButton(
            onPressed: () => {_login(context)},
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60)),
            child: const Text(
              'Entrar',
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
          ),
          TextButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupView()),
              )
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60)),
            child: const Text(
              'Não tenho uma conta...',
            ),
          ),
        ],
      ),
    );
  }
}
