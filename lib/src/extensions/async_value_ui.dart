import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showSnackBarOnError(BuildContext context) => whenOrNull(
      error: (error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(error.toString()),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                    label: 'Copy Error',
                    backgroundColor: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    onPressed: () => Clipboard.setData(
                        ClipboardData(text: error.toString())))),
          ));


  /// Shows a dialog with the error message when the AsyncValue is an error.
  /// If the error is the same as the last error shown with this method, the dialog will not be shown.
  void showDialogOnError(BuildContext context) {
    whenOrNull(error: (error, stackTrace) { 
      if (_lastError != error.toString()){
        _lastError = error.toString();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: SingleChildScrollView(child: Text(error.toString())),
                actions: [
                  TextButton(
                    onPressed: () {
                      _lastError = null;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Dismiss'),
                  ),
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: error.toString()));
                      _lastError = null;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Copy'),
                  ),
                ],
              ));
      }

    });
  }
  
}

String? _lastError;