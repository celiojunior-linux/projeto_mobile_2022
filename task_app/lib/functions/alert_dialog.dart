import 'package:flutter/material.dart';

class Dialogue {
  final BuildContext context;
  final Icon icon;
  final String title;

  Dialogue({required this.context, required this.icon, required this.title});

  void show(String message) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(icon: icon, title: Text(title), content: Text(message)),
    );
  }
}

class ValidationDialogue extends Dialogue {
  ValidationDialogue({required super.context})
      : super(icon: const Icon(Icons.error), title: 'Erro de validação');
}
