import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> showErrorDialog(BuildContext context, String error) {
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
            ],
          ));
}
