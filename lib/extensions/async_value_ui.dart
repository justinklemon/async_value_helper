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

  void showDialogOnError(BuildContext context) {
    whenOrNull(
        error: (error, stackTrace) => showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: SingleChildScrollView(child: Text(error.toString())),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Dismiss'),
                    ),
                    TextButton(
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: error.toString()));
                        Navigator.of(context).pop();
                      },
                      child: const Text('Copy Error'),
                    ),
                  ],
                )));
  }
  //   void showLoadingOverlay(BuildContext context) => whenOrNull(
  //   data: (_) => Container(),
  //   loading: () => Stack(
  //     fit: StackFit.expand,
  //     children: [
  //       ModalBarrier(dismissible: false, color: Colors.black.withOpacity(0.3)),
  //       const Center(child: CircularProgressIndicator()),
  //     ],
  //   ),
  //   error: (_, __) => Container(),
  // );
}
