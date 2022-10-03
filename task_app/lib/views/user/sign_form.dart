import 'package:flutter/material.dart';
import 'package:task_app/functions/alert_dialog.dart';
import 'package:task_app/models/user.dart';
import 'package:task_app/services/user_service.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  void _create(context) {
    ValidationDialogue dialoguer = ValidationDialogue(context: context);
    if (_usernameController.text.replaceAll(' ', '') == '') {
      dialoguer.show('Nome de usuário inválido');
      return;
    }
    if (_passwordController.text == '') {
      dialoguer.show('Senha inválida');
      return;
    }
    if (_passwordController.text != _passwordConfirmController.text) {
      dialoguer.show('As senhas não conferem');
      _passwordController.text = '';
      _passwordConfirmController.text = '';
      return;
    }
    User user = User(
        id: null,
        username: _usernameController.text,
        password: _passwordController.text);
    UserService().createUser(user.toJson()).then((created) {
      if (created == true) {
        Dialogue(
                context: context,
                icon: const Icon(Icons.done),
                title: 'Sucesso')
            .show('Usuário registrado');
      }
      _usernameController.text = '';
      _passwordController.text = '';
      _passwordConfirmController.text = '';
    }).catchError((error) {
      ValidationDialogue(context: context).show(error);
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
              label: Text('Usuário (Ex. celio)'),
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
            ),
            keyboardType: TextInputType.text,
            controller: _passwordController,
            obscureText: true,
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Confirme a senha'),
            ),
            keyboardType: TextInputType.text,
            controller: _passwordConfirmController,
            obscureText: true,
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
