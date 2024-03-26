import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context,
    {required String title, required String message}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        )
      ],
    ),
  );
}

