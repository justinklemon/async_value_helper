import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActionForErrorDialog {
  final String label;
  final VoidCallback onPressed;

  ActionForErrorDialog({required this.label, required this.onPressed});
}

Future<void> showErrorDialog(BuildContext context, String error, {ActionForErrorDialog? action}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: SingleChildScrollView(child: Text(error.toString())),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Dismiss'),
              ),
              TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: error));
                  Navigator.of(context).pop();
                },
                child: const Text('Copy'),
              ),
              if (action != null)
                ElevatedButton(
                  onPressed: () {
                    action.onPressed();
                    Navigator.of(context).pop();
                  },
                  child: Text(action.label),
                ),
            ],
          ));
}
